/*
 * Package : Coap
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/06/2018
 * Copyright :  S.Hamblett
 *
 * A put request is used to create data on the storage testserver resource
 */

import 'dart:async';
import 'dart:io';
import 'package:coap/coap.dart';

FutureOr<void> main(List<String> args) async {
  // Create a configuration class. Logging levels can be specified in the configuration file
  final CoapConfig conf = CoapConfig(File('example/config_all.yaml'));

  // Build the request uri, note that the request paths/query parameters can be changed
  // on the request anytime after this initial setup.
  const String host = 'localhost';

  final Uri uri = Uri(scheme: 'coap', host: host, port: conf.defaultPort);

  // Create the client.
  // The method we are using creates its own request so we do not need to supply one.
  // The current request is always available from the client.
  final CoapClient client = CoapClient(uri, conf);

  // Adjust the response timeout if needed, defaults to 32767 milliseconds
  //client.timeout = 10000;

  // Create the request for the pu request
  final CoapRequest request = CoapRequest.newPut();
  request.addUriPath('storage');
  client.request = request;

  print('EXAMPLE - Sending put request to $host, waiting for response....');

  CoapResponse response = await client.put('SJHTestPut');
  if (response != null) {
    print('EXAMPLE - put response received, sending get');
    print(response.payloadString);
    // Now get and check the payload
    final CoapRequest getRequest = CoapRequest.newGet();
    getRequest.addUriPath('storage');
    client.request = getRequest;
    response = await client.get();
    if (response != null) {
      print('EXAMPLE - get response received');
      print(response.payloadString);
      if (response.payloadString == 'SJHTestPut') {
        print('EXAMPLE - Hoorah! the put has worked');
      } else {
        print('EXAMPLE - Boo! the put failed');
      }
    } else {
      print('EXAMPLE - no get response received');
    }
  } else {
    print('EXAMPLE - no put response received');
  }

  // Clean up
  client.close();

  exit(0);
}