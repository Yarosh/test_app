class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :report_session_data_to_ironline

  def report_session_data_to_ironline
    #duplicate request
    req = request.dup
    
    #extract data from headers
    data = {}
    http_headers = req.headers
    data['remote_ip'] = req.remote_ip
    data['server_port'] = req.protocol
    data['host'] = req.host
    data['protocol'] = http_headers['SERVER_PROTOCOL']
    data['method'] = req.request_method
    data['query_string'] = req.query_string
    data['path'] = req.path_info
    data['user_agent'] = req.user_agent
    data['accept_encoding'] = req.accept_encoding
    data['accept_language'] = req.accept_language
    data['http_referer'] = req.referer

    #serialize
    json_data = data.to_json
    
    #send via UDP
    udp_socket = UDPSocket.new
    udp_socket.send(json_data, 0, '127.0.0.1', 9292)

    p "boom"
  end

end
