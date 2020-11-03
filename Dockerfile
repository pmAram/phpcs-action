#FROM php:7.2-cli

#RUN apt-get update && \
#    apt-get upgrade -y && \
#    apt-get install -y git
#RUN pear install PHP_CodeSniffer-2.9.0
#RUN cd /usr/local/lib/php/PHP/CodeSniffer/Standards/ && git clone git://github.com/ludofleury/symfony-coding-standard.git Symfony

#RUN apt-get install -y jq

#COPY entrypoint.sh \
#     problem-matcher.json \
#     /action/

#RUN chmod +x /action/entrypoint.sh

#ENTRYPOINT ["/action/entrypoint.sh"]


FROM cytopia/phpcs:3

RUN apk add --no-cache jq

COPY entrypoint.sh \
     problem-matcher.json \
     /action/

RUN chmod +x /action/entrypoint.sh

ENTRYPOINT ["/action/entrypoint.sh"]
