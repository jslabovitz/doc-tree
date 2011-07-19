require 'rack'
require 'pathname'

module Rack
  
  class DocTree
    
    def initialize(app, options={})
      @app = app
      @tree = options[:tree]
      @redirect_to_latest_from_path = options[:redirect_to_latest_from_path]
    end
    
    def call(env)
      request = Rack::Request.new(env)
      if request.get? || request.head?
        path = Pathname.new(request.path_info).cleanpath.to_s
        if path == @redirect_to_latest_from_path
          doc = @tree.latest
          response = Rack::Response.new
          response.header['Content-Type'] = 'text/plain'
          response.redirect(doc.path, 303)
          return response.finish
        end
        if (doc = @tree[path])
          response = Rack::Response.new
          response.header['Last-Modified'] = doc.mtime.to_s if doc.mtime
          response.header['Content-Type'] = 'text/html; charset=utf-8'
          response.body = [doc.to_html]
          return response.finish
        end
      end
      @app.call(env)
    end
    
  end
  
end