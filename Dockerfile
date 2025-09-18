FROM gcc:latest

COPY collatz.c /collatz.c

RUN gcc /collatz.c -o /collatz

ENTRYPOINT ["/collatz"]