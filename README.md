GenstageDemo
============

Demo Application for demonstrating use of `GenStage` with Amazon SQS

## Installation

```
mix deps.get
iex -S mix
```

## Walkthrough

- `application.ex` describes the main Application behaviour that starts our GenStage process.
- `producer.ex` is a basic GenStage producer. It responds to demand from workers by fetching messages from SQS in batches of 10 or less
- `consumer.ex` is a basic GenStage consumer. It receives asks for messages from the producer and prints them to the console, then deletes the message from SQS
- `event_emitter.ex` is a GenServer that writes a message to SQS once per second with a body of just the system time in millis
- `consumer_supervisor.ex` is a GenStage ConsumerSupervisor. It sends demand upstream to the Producer and spawns a Printer process for each message it receives
- `printer.ex` is a simple message processor that prints a message, then deletes it from SQS.
