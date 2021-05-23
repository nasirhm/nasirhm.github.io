---
title: "Exploring Google Cloud: Pub/Sub 101"
date: 2021-05-23T19:25:32+05:00
tags: ["gcp", "google", "cloud"]
categories: ["google"]
---

![Google Pub Sub](/images/posts-static/exploring-google-cloud/pub_sub-512-color.png)

In the past few days, I've been exploring services in Google Cloud Platform and I'll be writing a series as "Exploring Google Cloud" to write about my learnings and take aways here.

In this series, I'll be writing about Google Cloud Products which we can explore in our 300$ trial period.

We'll be starting with one of the awesome products provided to us by Google Cloud called Pub/Sub.

## What is Cloud Pub/Sub?

Pub/Sub is short for Publish/Subscribe Messaging and it is an asynchronous messaging service that decouples services that produce events from services that process events.

**Availability:** Global (In all GCP Regions around the world)

Let's dig a little deeper into it.

It's used in event-driven applications, where we can have applications publishing and subscribing to events that are available as messages.

As the name suggests, Pub/Sub Works in a Publisher / Subscriber model, Where a publisher publishes a message and the subscriber acknowledges that message.

How do we make sure that the Publisher publishes to the right place and the subscriber is listening to the right place? It's where topics come in.

### Core Components:

Let's look at the Core constructs of what Pub/Sub is made of:

- **Topic:** An intermediary channel that maintains a list of subscribers to relay messages to that are received from publishers
- **Message:** Serialized messages sent to a topic by a publisher which has no knowledge of the subscribers
- **Publisher:** An application which publishes a message to a topic.
- **Subscriber:** An application that registers itself with the desired topic in order to receive the appropriate messages.

### Pub/Sub Model:

As we now understand the Core components, Let's look at how the Pub/Sub Model Works:

- We start with creating a topic in Pub/Sub.
- We then create a subscription for that topic, It plays the subscriber part of the Pub/Sub.
- Now, we can publish messages in our Pub/Sub topic.
- The messages are available in our Pub/Sub topic, Now the subscriber can consume those messages by acknowledging them.

Here's a pictorial overview of it:

![Google Cloud Pub/Sub Model Overview](/images/posts-static/exploring-google-cloud/gcp-pub-sub-01.png)

In the example above, We've got two seperate topics where messages will be published and a single consumer having two subscriptions providing the consumer the ability to consume messages from both the topics.

The same can be done for a publisher, a single publisher can publish messages to multiple topics too.

### Some Benefits of Cloud Pub/Sub:

**Loose Coupling:** Publishers are unaware of the subscribers presence. It provides the ability for the system to function independently of each other.

**Scalability:** Pub/sub messaging can scale to volumes beyond the capability of a single traditional data center. 

### Let's get hands-on with it.

Once, you've got your GCP account and gcloud CLI setup, We can make use of the gcloud CLI for this demo.

### Demo:

Let's assume the following scenario:

We're running a Coffee Shop, Where customers have the ability to push messages to a topic with their order about cofee.

On each station our Baristas are subscribed to the topic and can pull one message at the time and ackowledge it to start brewing coffee for the customer.

### Setup:

#### Creating the topic:

To create the topic in pub/sub, we'll use glcoud CLI as following:

```shell
$ gcloud pubsub topics create coffee-shop
```

As we've got the topic created as `coffee-shop`, It's time for the barista to join as a subscriber.

#### Creating a subscription for the topic:

```shell
$ gcloud pubsub subscriptions create --topic coffee-shop barista
```

In the above example, we're creating a subscription as `barista` which subscribes to the topic created in the past step.

Yayyy !!, We're done with our setup for Pub/Sub. Now we can integrate it with our applications as subscribers and publishers.

#### Publishing and Consuming Messages:

Let's assume, we've got a customer, who needs an espresso with cinnamon, They can publish the following message in the `coffee-shop` topic as: `{"coffee_type": "espresso", "cinnamon": "true"}`

We can use the gcloud CLI to publish this message as:

```shell
$ gcloud pubsub topics publish coffee-shop --message '{"coffee_type": "espresso", "cinnamon": "true"}'
```

The gcloud CLI will publish the message on the `coffee-shop` topic.

And then we'll have our barista free to take a coffee order, They can use their subscription to consume the messages, We'll use Gcloud CLI for it too:

```
$ gcloud pubsub subscriptions pull barista --limit=1 --auto-ack
```

**NOTE:** We're using the `--limit` flag to make sure, we only receive one message from the topic.

**NOTE:** For the `--auto-ack` flag to automatically acknowledge the message.

It's available there to make sure the consumer receives the message successfully by acknowledging it's receival.

We can also manually acknowledge the messages, [Click here](https://cloud.google.com/community/tutorials/pubsub-quickstart) to learn more about it.

## Summary:

- Publish/subscribe messaging is when a publisher sends a message to a topic and the message is forwarded to a subscriber.
- The concept of pub/sub is easy to understand but every coding and programming language handles it differently, making it a little more challenging to learn across all platforms.
- On the edge, message delivery times can be two to four times faster by using a network backbone and multiple points of presence.

Thank You for Reading ! Stay tuned, I'll be writing more about GCP Products and my experience with them in the near future.

Looking forward to your feedback on the post.

---
