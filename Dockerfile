FROM ubuntu:18.04
   
# Prerequisites
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget
   
# Set up new user
RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer
RUN touch text.txt
#RUN wget -O azcopy_v10.tar.gz https://aka.ms/downloadazcopy-v10-linux
#RUN tar -xf azcopy_v10.tar.gz --strip-components=1 && ls -al
#RUN ls && ./azcopy
#ENV PATH "$PATH:/home/developer"
#RUN azcopy copy ./text.txt https://blobforapk.blob.core.windows.net/apk?sv=2020-08-04&ss=bfqt&srt=sco&sp=rwdlacupitfx&se=2021-12-26T02:58:10Z&st=2021-12-25T18:58:10Z&spr=https&sig=1H6Xak05Vk0OVYOWryuSGNjUS%2Bu5jY9TByS09xCyQmE%3D
#   
# Prepare Android directories and system variables
RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT /home/developer/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg
   
# Set up Android SDK
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/sdk/tools
RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
ENV PATH "$PATH:/home/developer/Android/sdk/platform-tools"

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git 
RUN cd /home/developer/flutter && git checkout 2.0.6
ENV PATH "$PATH:/home/developer/flutter/bin"
   
# Run basic check to download Dark SDK
RUN flutter doctor && mkdir demo
COPY ./workspace/demo/* .
RUN ls
RUN cd demo && flutter pub get && flutter build apk
