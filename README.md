# RequestCF
This is Simple HTTP Library for handling http requests inside of coldfusion

##Description
The RequestCF Library is for making HTTP calls to webservices.  This is a designed to make the cfhttp and httpService calls seamlessly along with automatically parsing the response if XML or JSON.

##Author
William Giles

##License
MIT http://opensource.org/licenses/MIT

##Installation

Request CF is installed using CFPM or can be downloaded from source

###CFPM

    cfpm request

##Basic Usage

In application.cfc:

    application.cfpm = new cfpm();
    application.request = application.cfpm.require('request');
    application.request.get('http://google.com');

##Methods

###post
Requires: (string) requestURL, (struct) params={}, (struct) headers={}, (string) body=''
Returns: Parsed HTTP Response (JSON, XML or String)
Function: Makes an HTTP POST Request to the requestURL passing along the params as formField variables and includes any headers and/or body.
Example:

	var apiResponse = application.udfs.api().post('http://google.com', {query: 'cats'});

###get
Requires: (string) requestURL, (struct) params={}, (struct) headers={}
Returns: Parsed HTTP Response (JSON, XML or String)
Function: Makes an HTTP GETRequest to the requestURL passing along the params as query string variables and includes any headers.
Example:

	var apiResponse = application.udfs.api().get('http://google.com', {query: 'cats'});

##Notes
The RequestCF Library checks http status codes before parsing the HTTP Response.  If it detects a non-200 status code (not 200-299), then it will throw and error with a message code that contains the status code.  The HTTP Response will be stored in the this.response variable if you wish to inspect the output.  With this being said, it is recommended to wrap each call in a try/catch to ensure no error affect the users. Full example below

	try{
	    var api = application.udfs.api();
	    var response = api.get('http://google.com');
	}catch(any e){
	    WriteOutput('Something went wrong with the HTTP call');
	    WriteDump(api.response);
	}