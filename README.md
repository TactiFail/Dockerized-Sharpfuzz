# Dockerized-Sharpfuzz
A simple Dockerfile for running [SharpFuzz](https://github.com/Metalnem/sharpfuzz)

## Usage

1. `docker build -t sharpfuzz .`
2. `docker run -it sharpfuzz`

That's about it for the Docker part. Once inside:

1. Import whatever packages you need inside the `tearget` folder
2. Set up your test harness in `target/Program.cs`
3. Put valid test cases in `inputs`
4. `./run.sh` will take care of the rest
