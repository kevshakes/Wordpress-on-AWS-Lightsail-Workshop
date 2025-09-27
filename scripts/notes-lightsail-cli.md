# Optional AWS CLI Tips for Lightsail (Bonus)

> These commands require the AWS CLI configured with credentials and region.

List instances:
```bash
aws lightsail get-instances --query 'instances[*].{name:name,state:state.name,ip:publicIpAddress}'
```

List static IPs:
```bash
aws lightsail get-static-ips --query 'staticIps[*].{name:name,ip:ipAddress,attachedTo:attachedTo}'
```

Create a static IP and attach (example):
```bash
aws lightsail allocate-static-ip --static-ip-name workshop-ip
aws lightsail attach-static-ip --static-ip-name workshop-ip --instance-name workshop-wp
```

Open ports (HTTP/HTTPS) on the instance's firewall (if needed):
```bash
aws lightsail put-instance-public-ports --instance-name workshop-wp --port-infos '[
  {"fromPort":80,"toPort":80,"protocol":"tcp"},
  {"fromPort":443,"toPort":443,"protocol":"tcp"}
]'
```
