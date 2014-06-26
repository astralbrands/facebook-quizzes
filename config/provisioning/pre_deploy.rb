policy :pre_deploy, roles: :app do
  requires :ruby_web_project
  requires :postgres
end