#!/bin/bash
set -euo pipefail
set -x

# ====== CONFIG ======
POD_CIDR="10.244.0.0/16"   # for Flannel or compatible CNI

# ====== STEP 1: Disable swap ======
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab || true

# ====== STEP 2: Kernel modules & sysctl ======
cat <<EOF | tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system

# ====== STEP 3: Install containerd ======
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  apt-transport-https ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | gpg --dearmor -o /usr/share/keyrings/docker.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  > /etc/apt/sources.list.d/docker.list

apt-get update
apt-get install -y containerd.io

mkdir -p /etc/containerd
containerd config default | tee /etc/containerd/config.toml >/dev/null

# Use systemd cgroup driver (recommended by Kubernetes)
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml

systemctl restart containerd
systemctl enable containerd

# ====== STEP 4: Install kubeadm, kubelet, kubectl (from pkgs.k8s.io) ======

# Remove any old repo definitions (just in case)
rm -f /etc/apt/sources.list.d/kubernetes.list || true
sed -i '/kubernetes-xenial/d' /etc/apt/sources.list || true

mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key \
  | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

cat <<EOF | tee /etc/apt/sources.list.d/kubernetes.list
deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /
EOF

apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

systemctl enable kubelet
systemctl start kubelet || true  # it may crashloop until init

# ====== STEP 5: kubeadm init ======
LOCAL_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

kubeadm init \
  --apiserver-advertise-address="${LOCAL_IP}" \
  --pod-network-cidr="${POD_CIDR}"

# ====== STEP 6: Configure kubectl for ubuntu user ======
USER_HOME="/home/ubuntu"
mkdir -p "${USER_HOME}/.kube"
cp /etc/kubernetes/admin.conf "${USER_HOME}/.kube/config"
chown -R ubuntu:ubuntu "${USER_HOME}/.kube"

# ====== STEP 7: Install CNI (Flannel example – simple & works with 10.244.0.0/16) ======
sudo -u ubuntu kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

echo "=================================================="
echo
