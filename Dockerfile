FROM docker.io/rakudo-star:latest

# docker build --build-arg quay_expiration="4w" -t quay.io/your-repo/your-image:tag .
ARG quay_expiration=never
LABEL quay.expires-after=${quay_expiration}

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y uuid-dev libpq-dev libssl-dev unzip build-essential && \
    apt-get purge -y

RUN mkdir /app
COPY META6.json /app
WORKDIR /app
RUN zef install --/test --deps-only --verbose .

COPY . /app
RUN raku -c -Ilib service.raku
ENV CRO_WEBSITE_HOST=0.0.0.0
ENV CRO_WEBSITE_PORT=4000
CMD ["raku", "-Ilib", "service.raku"]
