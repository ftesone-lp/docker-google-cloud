FROM debian

# actualizar repositorios e instalar utilidades
RUN apt-get update -y && apt-get install -y python curl vim gnupg

# instalar gcloud sdk
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-231.0.0-linux-x86_64.tar.gz
RUN tar zxvf google-cloud-sdk-231.0.0-linux-x86_64.tar.gz google-cloud-sdk
RUN rm google-cloud-sdk-231.0.0-linux-x86_64.tar.gz
RUN /google-cloud-sdk/install.sh -q
RUN ln -s /google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud

# actualizar gcloud
RUN gcloud components update -q

# instalar kubectl
RUN apt-get update && apt-get install -y apt-transport-https
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update && apt-get install -y kubectl

# definir directorio de trabajo
WORKDIR /google-cloud-sdk

# ejecutar bash
CMD ["bash"]
