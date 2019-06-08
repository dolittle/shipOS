FROM ubuntu AS build

# Download and install hugo
ENV HUGO_VERSION 0.55.5
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.deb

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} /tmp/hugo.deb
RUN dpkg -i /tmp/hugo.deb \
	&& rm /tmp/hugo.deb

WORKDIR /Source
ADD Source .
RUN hugo

# Build runtime image
FROM nginx:1.15-alpine
COPY --from=build /Source/public /usr/share/nginx/html
COPY --from=build /Source/nginx-default.conf /etc/nginx/conf.d/default.conf
