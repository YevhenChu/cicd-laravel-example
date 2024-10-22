FROM rabbitmq:management

RUN set eux; \
    rabbitmq-plugins enable --offline rabbitmq_consistent_hash_exchange

# RUN addgroup -S rabbitmq && adduser -S -H rabbitmq -G rabbitmq

ADD rabbitmq.conf /etc/rabbitmq/
ADD .erlang.cookie var/lib/rabbitmq/.erlang.cookie

# Do we need to add user
RUN chmod u+rw /etc/rabbitmq/rabbitmq.conf \
&& chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie \
&& chmod 400 /var/lib/rabbitmq/.erlang.cookie