# Mobile SDK Getting started

## iOS Platform

1. Embed SDK framework sdkmobile.framework in your Xcode project
2. Import Communicator.h header into project sources
3. Get CallClient instance using getCallClientInstance method of Communicator
4. Activate the sip account using activate method of CallClient
5. Login parameter is formed like sip:<sip account id>@sip-eu.apifonica.com (ex. sip:883140776193139@sip-eu.apifonica.com)
6. When is account activated an activation event will be send to ActivationDelegate which should be set to CallClient instance before an activation started
7. Make a call using callToNumber method of CallClient instance
8. More detailed information of how to use sdk is shown in our example

## Android Plaform

1. Embed SDK sdkmobilej.jar and libsdkmobile.so files in your project in the way as it is shown in our example
2. Import namespace com.scs.* into project java sources
3. Initialize SDK calling SdkMobile.INSTANCE.initialize method
4. Get CallClient instance using getCallClient method of SdkMobile.INSTANCE
5. Activate the sip account using activate method of ICallClient interface
5. Login parameter is formed like sip:<sip account id>@sip-eu.apifonica.com (ex. sip:883140776193139@sip-eu.apifonica.com)
6. When is account activated an activation event will be send to IActivationListener which should be set to CallClient instance before an activation started
7. Make a call using callToNumber method of ICallClient interface
8. More detailed information of how to use sdk is shown in our example