# 📌 Accessing Kubernetes Services with NodePort and Tailscale

If your service is exposed using a `NodePort`, and you're **not** using an Ingress or Tunnel, then:

## ✅ You MUST use:

```
http://<TAILSCALE-IP-OF-NODE>:<NODEPORT>
```

---

## 🧠 Why This Works:

- Kubernetes `NodePort` exposes the service on a static port (e.g., `30402`) on **the node where the pod is running**.
- **Tailscale IP** lets you access that node securely from anywhere in your mesh network.
- Use:
  - `kubectl get svc` → to find the NodePort
  - `kubectl get pod -o wide` → to find which node the pod is running on
  - `tailscale ip` → to get that node's reachable IP

