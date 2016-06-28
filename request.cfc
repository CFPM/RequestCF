component {
	public function init(){
		return this;
	}
	public function post(requestURL, params={}, headers={}, body=''){
		this.lastURL = requestURL;
		createService('POST', requestURL);
		addParams(params, 'formField');
		addHeaders(headers);
		addBody(body);
		var response = sendRequest();
		destroyService();
		return response;
	}
	public function get(requestURL, params={}, headers={}){
		this.lastURL = requestURL;
		createService('GET', requestURL);
		addParams(params, 'URL');
		addHeaders(headers);
		var response = sendRequest();
		destroyService();
		return response;
	}

	private function createService(method, requestURL){
		this.httpService = new http(method=method, url=requestURL);
	}

	private function addParams(params={}, type){
		for(key in params){
			this.httpService.addParam(type=type, name=key, value=params[key]);
		}
	}

	private function addHeaders(headers={}){
		for(key in headers){
			this.httpService.addParam(type='header', name=key, value=headers[key]);
		}
	}

	private function addBody(body=''){
		if(trim(body) != ''){
			this.httpService.addParam(type='body', value=trim(body));
		}
	}

	private function sendRequest(){
		this.response = this.httpService.send().getPrefix();
		if(left(this.response.statuscode, 2) == '20'){
			try{
				this.results = deserializeJSON(this.response.filecontent);
			}catch(any e){
				try{
					if(isXML(this.response.filecontent)){
						this.results = XMLParse(this.response.filecontent);
					}else{
						this.results = this.response.filecontent;
					}
				}catch(any e){
					this.results = this.response.filecontent;
				}
			}
			return this.results;
		}else{
			throw('Received status #result.statuscode# for request to: #this.lastURL#');
		}
	}

	private function destroyService(){
		this.httpService = '';
	}
}