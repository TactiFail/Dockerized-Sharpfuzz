FROM ubuntu:mantic

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /root

# Setup
RUN apt update && \
	apt install -y git wget make apt-transport-https software-properties-common dotnet-sdk-8.0 vim build-essential python3-dev automake cmake flex bison libglib2.0-dev libpixman-1-dev python3-setuptools cargo libgtk-3-dev locales
RUN apt install -y lld-14 llvm-14 llvm-14-dev clang-14 || sudo apt-get install -y lld llvm llvm-dev clang
RUN apt install -y gcc-$(gcc --version|head -n1|sed 's/\..*//'|sed 's/.* //')-plugin-dev libstdc++-$(gcc --version|head -n1|sed 's/\..*//'|sed 's/.* //')-dev
RUN git clone https://github.com/Metalnem/sharpfuzz/

# AFL++
RUN git clone https://github.com/AFLplusplus/AFLplusplus && \
	cd AFLplusplus && \
	make all && \
	make install && \
	cd .. && \
	rm -rf AFLplusplus

# dotnet tools
RUN dotnet tool install -g SharpFuzz.CommandLine
RUN dotnet tool install -g powershell
ENV PATH="${PATH}:/root/.dotnet/tools"

# SharpFuzz
WORKDIR /root/
RUN mkdir inputs
RUN dotnet new console -n target && \
	cd target && \
	dotnet add package SharpFuzz
RUN echo "pwsh sharpfuzz/scripts/fuzz.ps1 target/target.csproj -i inputs" > run.sh && \
	chmod +x run.sh
