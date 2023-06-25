# Salesforce Dynamic Events

Dynamically publish and handle platform events from flows or apex. With dynamic events, you can build different event types on the fly without needing to configure new platform events. This project aims to make it easier to work asynchronously in Salesforce.

-   Publish and handle events from flows or apex
-   Easily handle record and prior record data asynchronously
-   Improved reporting on event usage and error logging
-   Useful tools for testing and troubleshooting events

## Installation

Go to https://login.salesforce.com/packaging/installPackage.apexp?p0=04t5G00000480n7QAA to install in production.

Go to https://test.salesforce.com/packaging/installPackage.apexp?p0=04t5G00000480n7QAA to install in sandbox.

Or clone the repository to deploy to your own org or scratch org.

## Getting Started

In all cases, there is a 3 step process for using dynamic events

1. Publish your event
2. Create a handler to process the event asynchronously
3. Register your handler to process the event

## Getting Started with Flows

Publish your event from a flow. There are 3 options.

![Publishing a dynamic event from Flow](/markdown_content/publishFromFlow.png)

### Publish Event with Record Data

Probably the easiest method. It will pass the record data and prior record data into an event. The event can be handled by a flow or apex.

When creating a flow to handle the event. Choose an Automated Flow and create 2 record variables called `Record` and `RecordPrior`. Mark both variables available for input.

![Create Record and RecordPrior record variables and mark them avilable for input](/markdown_content/createRecordVariables.png)

Register your flow handler so that it will fire when the event is published. Go to Setup > Custom Metadata Types and manage the `Event Handler Route` metadata.
![Register your flow](/markdown_content/registerRecordFlow.png)
**Event Handler Route Name** This will be the name of your event. It should be all one word.

**HandlerApiName** This is the api name of your flow that will handle the event.

**Active** Check this so that the flow will run. Uncheck if you want to disable it.

**EvtRunner** Choose EvtRecordFlowRunner for publishing events with record data. the EvtRunner tells the system how to process the message to invoke the flow with the correct record values.

### Publish Event with Key Value Pairs

Supply field names and values to send in the event. The values will be sent as variables to the flow that handles the event. It can also be processed by apex.

When creating a flow to handle the event. Choose an Automated Flow and create the variables with names matching your Keys. Mark the variables available for input.

Register your flow handler so that it will fire when the event is published. Go to Setup > Custom Metadata Types and manage the `Event Handler Route` metadata. Choose **EvtFlowRunner** as the `EvtRunner`. This tells the system how to process the message to invoke the flow.

### Publish Event with JSON

Supply the data as a JSON object. The fields in the JSON object will be sent as variables to the flow that handles the event. It can also be processed by apex.

When creating a flow to handle the event. Choose an Automated Flow and create the variables with names matching your JSON fields (nested JSON data is not supported). Mark the variables available for input.

Register your flow handler so that it will fire when the event is published. Go to Setup > Custom Metadata Types and manage the `Event Handler Route` metadata. Choose **EvtFlowRunner** as the `EvtRunner`. This tells the system how to process the message to invoke the flow.

## Getting Started with Apex

### Publish a dynamic event with an Object

Create a class for your message

```apex
public class NameChanged {
    public String oldName;
    public String newName;
}
```

Publish your event

```apex
NameChanged msg = new NameChanged();
msg.oldName = 'Sam';
msg.newName = 'notSam';

Evt.publish('NameChanged', msg);
```

Handle the event

```apex
public NameChangedHandler extends EvtAbstractHandler {
    // This is needed to properly cast your message to the correct message type.
    protected override System.Type getMessageType() {
        return List<NameChanged>.class;
    }

    // This is where the actual processing of your message takes place.
    protected override void handle(List<Object> messageList) {
        for (NameChanged msg : (List<NameChanged>) messageList) {
            // do something
        }
    }
}
```

Register your handler
![Creating metadata to map event to the handler your created](/markdown_content/registerNameChanged.png)

### Publish a dynamic event for a record update

Publish your event

```apex
trigger ContactTrigger on Contact(after update) {
    for (Contact con : (List<Contact>) Trigger.new) {
        Contact oldCon = (Contact) Trigger.oldMap.get(con.Id);
        Evt.publish('ContactUpdate', con, oldCon);
    }
}
```

Handle the event

```apex
public class ContactUpdate extends EvtAbstractRecordHandler {
    protected override void handle(EvtRecordContext ctx) {
        for (Contact con : (List<Contact>) ctx.newList) {
            Contact oldCon = (Contact) ctx.oldMap.get(con.Id);
            if (con.LastName != oldCon.LastName) {
                // do something
            }
        }
    }
}
```

Register your handler
![Creating metadata to map event to the handler your created](/markdown_content/registerContactUpdate.png)

## Reporting and Administration

### EvtAdmin App

The EvtAdmin app offers a useful homepage for reporting and testing.

-   See how breakdown of logs by type by day
-   View errors by type and also a list of the most recent errors
-   Flow for manually firing events for testing
    -   **Type** The name of the event.
    -   **Data** A JSON object of the message to be delivered.

![EvtAdmin Home](/markdown_content/evtAdminApp.png)

### EvtLogs

From the EvtLog, you can see a full stack trace for errors. The message also appears in a flow on the right to be reprocessed.

![EvtLog page](/markdown_content/evtLog.png)

### That's too many logs!

There is a flow called `EvtLogCleanup` that will run every morning to delete logs older than 7 days. This flow can be adjusted to delete on a more frequent basis.
