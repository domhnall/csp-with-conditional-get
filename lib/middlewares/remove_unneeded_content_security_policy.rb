class RemoveUnneededContentSecurityPolicy
  POLICY_KEY = "Content-Security-Policy"
  CONTENT_TYPE_KEY = "Content-Type"

  def initialize(app)
   @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    if status==304
      headers.delete(POLICY_KEY)
    end
    [status, headers, response]
  end
end 
