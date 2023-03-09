(*
 * Copyright 2023 XXIV
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *)
unit hyper;

{$ifdef fpc}
{$packrecords c}
{$endif}

interface

uses ctypes;

  type
     hyper_body		       = record
				 end; 
     Phyper_body	       = ^hyper_body;
     hyper_buf		       = record
				 end; 
     Phyper_buf		       = ^hyper_buf;
     PPhyper_buf	       = ^Phyper_buf;
     hyper_clientconn	       = record
				 end; 
     Phyper_clientconn	       = ^hyper_clientconn;
     hyper_clientconn_options  = record
				 end; 
     Phyper_clientconn_options = ^hyper_clientconn_options;
     hyper_context	       = record
				 end; 
     Phyper_context	       = ^hyper_context;
     hyper_error	       = record
				 end; 
     Phyper_error	       = ^hyper_error;
     hyper_executor	       = record
				 end; 
     Phyper_executor	       = ^hyper_executor;
     hyper_headers	       = record
				 end; 
     Phyper_headers	       = ^hyper_headers;
     hyper_io		       = record
				 end; 
     Phyper_io		       = ^hyper_io;
     hyper_request	       = record
				 end; 
     Phyper_request	       = ^hyper_request;
     hyper_response	       = record
				 end; 
     Phyper_response	       = ^hyper_response;
     hyper_task		       = record
				 end; 
     Phyper_task	       = ^hyper_task;
     hyper_waker	       = record
				 end; 
     Phyper_waker	       = ^hyper_waker;
     Pcuint8		       = ^cuint8;


  const
    HYPER_ITER_CONTINUE = 0;    
    HYPER_ITER_BREAK = 1;    
    HYPER_HTTP_VERSION_NONE = 0;    
    HYPER_HTTP_VERSION_1_0 = 10;    
    HYPER_HTTP_VERSION_1_1 = 11;    
    HYPER_HTTP_VERSION_2 = 20;    
    HYPER_IO_PENDING = 4294967295;    
    HYPER_IO_ERROR = 4294967294;    
    HYPER_POLL_READY = 0;
    HYPER_POLL_PENDING = 1;    
    HYPER_POLL_ERROR = 3;

  type
    Phyper_code = ^hyper_code;
    hyper_code = (HYPERE_OK,HYPERE_ERROR,HYPERE_INVALID_ARG,
      HYPERE_UNEXPECTED_EOF,HYPERE_ABORTED_BY_CALLBACK,
      HYPERE_FEATURE_NOT_ENABLED,HYPERE_INVALID_PEER_MESSAGE
      );
    Phyper_task_return_type = ^hyper_task_return_type;
    hyper_task_return_type = (HYPER_TASK_EMPTY,HYPER_TASK_ERROR,HYPER_TASK_CLIENTCONN,
      HYPER_TASK_RESPONSE,HYPER_TASK_BUF);
    hyper_body_foreach_callback = function (_para1:pointer; _para2:Phyper_buf):cint;cdecl;
    hyper_body_data_callback = function (_para1:pointer; _para2:Phyper_context; _para3:PPhyper_buf):cint;cdecl;
    hyper_request_on_informational_callback = procedure (_para1:pointer; _para2:Phyper_response);cdecl;
    hyper_headers_foreach_callback = function (_para1:pointer; _para2:Pcuint8; _para3:csize_t; _para4:Pcuint8; _para5:csize_t):cint;cdecl;
    hyper_io_read_callback = function (_para1:pointer; _para2:Phyper_context; _para3:Pcuint8; _para4:csize_t):csize_t;cdecl;
    hyper_io_write_callback = function (_para1:pointer; _para2:Phyper_context; _para3:Pcuint8; _para4:csize_t):csize_t;cdecl;

  function hyper_version:pcchar;cdecl;external;

  function hyper_body_new:Phyper_body;cdecl;external;

  procedure hyper_body_free(body:Phyper_body);cdecl;external;

  function hyper_body_data(body:Phyper_body):Phyper_task;cdecl;external;

  function hyper_body_foreach(body:Phyper_body; func:hyper_body_foreach_callback; userdata:pointer):Phyper_task;cdecl;external;

  procedure hyper_body_set_userdata(body:Phyper_body; userdata:pointer);cdecl;external;

  procedure hyper_body_set_data_func(body:Phyper_body; func:hyper_body_data_callback);cdecl;external;

  function hyper_buf_copy(buf:Pcuint8; len:csize_t):Phyper_buf;cdecl;external;

  function hyper_buf_bytes(buf:Phyper_buf):Pcuint8;cdecl;external;

  function hyper_buf_len(buf:Phyper_buf):csize_t;cdecl;external;

  procedure hyper_buf_free(buf:Phyper_buf);cdecl;external;

  function hyper_clientconn_handshake(io:Phyper_io; options:Phyper_clientconn_options):Phyper_task;cdecl;external;

  function hyper_clientconn_send(conn:Phyper_clientconn; req:Phyper_request):Phyper_task;cdecl;external;

  procedure hyper_clientconn_free(conn:Phyper_clientconn);cdecl;external;

  function hyper_clientconn_options_new:Phyper_clientconn_options;cdecl;external;

  procedure hyper_clientconn_options_set_preserve_header_case(opts:Phyper_clientconn_options; enabled:cint);cdecl;external;

  procedure hyper_clientconn_options_set_preserve_header_order(opts:Phyper_clientconn_options; enabled:cint);cdecl;external;

  procedure hyper_clientconn_options_free(opts:Phyper_clientconn_options);cdecl;external;

  procedure hyper_clientconn_options_exec(opts:Phyper_clientconn_options; exec:Phyper_executor);cdecl;external;

  function hyper_clientconn_options_http2(opts:Phyper_clientconn_options; enabled:cint):hyper_code;cdecl;external;

  function hyper_clientconn_options_headers_raw(opts:Phyper_clientconn_options; enabled:cint):hyper_code;cdecl;external;

  procedure hyper_error_free(err:Phyper_error);cdecl;external;

  function hyper_error_code(err:Phyper_error):hyper_code;cdecl;external;

  function hyper_error_print(err:Phyper_error; dst:Pcuint8; dst_len:csize_t):csize_t;cdecl;external;

  function hyper_request_new:Phyper_request;cdecl;external;

  procedure hyper_request_free(req:Phyper_request);cdecl;external;

  function hyper_request_set_method(req:Phyper_request; method:Pcuint8; method_len:csize_t):hyper_code;cdecl;external;

  function hyper_request_set_uri(req:Phyper_request; uri:Pcuint8; uri_len:csize_t):hyper_code;cdecl;external;

  function hyper_request_set_uri_parts(req:Phyper_request;scheme:Pcuint8;scheme_len:csize_t;authority:Pcuint8; authority_len:csize_t; 
             path_and_query:Pcuint8; path_and_query_len:csize_t):hyper_code;cdecl;external;

  function hyper_request_set_version(req:Phyper_request; version:cint):hyper_code;cdecl;external;

  function hyper_request_headers(req:Phyper_request):Phyper_headers;cdecl;external;

  function hyper_request_set_body(req:Phyper_request; body:Phyper_body):hyper_code;cdecl;external;

  function hyper_request_on_informational(req:Phyper_request; callback:hyper_request_on_informational_callback; data:pointer):hyper_code;cdecl;external;

  procedure hyper_response_free(resp:Phyper_response);cdecl;external;

  function hyper_response_status(resp:Phyper_response):cuint16;cdecl;external;

  function hyper_response_reason_phrase(resp:Phyper_response):Pcuint8;cdecl;external;

  function hyper_response_reason_phrase_len(resp:Phyper_response):csize_t;cdecl;external;

  function hyper_response_headers_raw(resp:Phyper_response):Phyper_buf;cdecl;external;

  function hyper_response_version(resp:Phyper_response):cint;cdecl;external;

  function hyper_response_headers(resp:Phyper_response):Phyper_headers;cdecl;external;

  function hyper_response_body(resp:Phyper_response):Phyper_body;cdecl;external;

  procedure hyper_headers_foreach(headers:Phyper_headers; func:hyper_headers_foreach_callback; userdata:pointer);cdecl;external;

  function hyper_headers_set(headers:Phyper_headers; name:Pcuint8; name_len:csize_t; value:Pcuint8; value_len:csize_t):hyper_code;cdecl;external;

  function hyper_headers_add(headers:Phyper_headers; name:Pcuint8; name_len:csize_t; value:Pcuint8; value_len:csize_t):hyper_code;cdecl;external;

  function hyper_io_new:Phyper_io;cdecl;external;

  procedure hyper_io_free(io:Phyper_io);cdecl;external;

  procedure hyper_io_set_userdata(io:Phyper_io; data:pointer);cdecl;external;

  procedure hyper_io_set_read(io:Phyper_io; func:hyper_io_read_callback);cdecl;external;

  procedure hyper_io_set_write(io:Phyper_io; func:hyper_io_write_callback);cdecl;external;

  function hyper_executor_new:Phyper_executor;cdecl;external;

  procedure hyper_executor_free(exec:Phyper_executor);cdecl;external;

  function hyper_executor_push(exec:Phyper_executor; task:Phyper_task):hyper_code;cdecl;external;

  function hyper_executor_poll(exec:Phyper_executor):Phyper_task;cdecl;external;

  procedure hyper_task_free(task:Phyper_task);cdecl;external;

  function hyper_task_value(task:Phyper_task):pointer;cdecl;external;

  function hyper_task_type(task:Phyper_task):hyper_task_return_type;cdecl;external;

  procedure hyper_task_set_userdata(task:Phyper_task; userdata:pointer);cdecl;external;

  function hyper_task_userdata(task:Phyper_task):pointer;cdecl;external;

  function hyper_context_waker(cx:Phyper_context):Phyper_waker;cdecl;external;

  procedure hyper_waker_free(waker:Phyper_waker);cdecl;external;
  
  procedure hyper_waker_wake(waker:Phyper_waker);cdecl;external;

implementation

end.
