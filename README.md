# Project Weka via Browser (noVNC) using Docker

This repository provides everything needed to run **Weka (GUI version)** directly from a web browser, without installing it locally or on compute nodes.

---

## Quick Start

### Start the container

From the project directory:

```bash
docker compose up -d
```

---

### Open Weka

In your browser:

(Use `localhost` if your machine is the host running Docker)

```
http://localhost:6080/vnc.html
```

---

### Using a remote server (2-step solution)

If Weka runs on a remote machine:

#### Step 1 — Create an SSH tunnel

```bash
ssh -L 6080:localhost:6080 user@remote_ip
```

(Yes, it is normal if the terminal appears frozen. Keep it open — closing it will stop the connection.)

#### Step 2 — Open the interface in your browser

```
http://localhost:6080/vnc.html
```

Weka should appear after a few seconds.

---

## Where to Put Your Files

Two folders are shared with the host machine:

| On the host machine          | Inside Weka |
|------------------------------|-------------|
| /home/user/weka/data         | /data       |
| /home/user/weka/results      | /results    |

---

### To use your datasets

Place your CSV/ARFF files in:

```
/home/user/weka/data
```

Inside Weka, open them from:

```
/data
```

---

### To save your results

Save them in:

```
/results
```

They will be available on the host machine in:

```
/home/user/weka/results
```

---

## Modify the "home user" directory

Edit the file:

```
docker-compose.yml
```

Replace:

```yaml
volumes:
  - /home/user/weka/data:/data
  - /home/user/weka/results:/results
```

For example, if your Linux username is `alice`:

```yaml
volumes:
  - /home/alice/weka/data:/data
  - /home/alice/weka/results:/results
```

Then restart:

```bash
docker compose down
docker compose up -d
```

---

## Memory Limit (RAM)

Currently, Weka is limited to **6 GB of RAM**.

This is defined in `start.sh`.

You should see:

```bash
java -Xms1g -Xmx5g -jar /opt/weka/weka.jar
```

- `-Xms` = minimum memory  
- `-Xmx` = maximum memory  

---

### Modify RAM

If you want 4 GB instead:

```bash
java -Xms1g -Xmx3g -jar /opt/weka/weka.jar
```

⚠️ **Always leave ~1 GB of margin between Docker memory and Java memory.**

---

### After Modifying Memory

Always restart:

```bash
docker compose down
docker compose build
docker compose up -d
```

---

## Stop Weka

```bash
docker compose down
```

---

## Common Issues

### Weka does not appear

Wait 10 seconds and refresh:

```
http://localhost:6080/vnc.html
```

---

### Port already in use

If you see:

```
port 6080 already in use
```

Modify `docker-compose.yml`:

```yaml
ports:
  - "6081:6080"
```

Then access via:

```
http://localhost:6081/vnc.html
```

Or using SSH tunneling:

```bash
ssh -L 6080:localhost:6081 user@remote_ip
```

Then in your browser:

```
http://localhost:6080/vnc.html
```

---

## Simplified Architecture

Browser  
⬇  
noVNC  
⬇  
VNC  
⬇  
Linux graphical interface  
⬇  
Weka  

---

## Summary

| Action    | Command                          |
|-----------|----------------------------------|
| Start     | docker compose up -d             |
| Stop      | docker compose down              |
| Access    | http://localhost:6080/vnc.html   |
| Datasets  | /home/user/weka/data             |
| Results   | /home/user/weka/results          |
