# config/initializers/content_security_policy.rb

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self, :https
    policy.font_src    :self, :https, :data
    policy.img_src     :self, :https, :data
    policy.object_src  :none
    
    # AJUSTE: Añadimos "'unsafe-inline'" para permitir los estilos en línea
    policy.style_src   :self, :https, "'unsafe-inline'"

    # AJUSTE: Añadimos "'unsafe-inline'" para permitir que importmap funcione
    policy.script_src  :self, :https, "https://ga.jspm.io", "'unsafe-inline'"
    
    # Esto ya estaba bien, permite que el worker de pdf.js se cargue
    policy.worker_src  :self, :blob

    # Esto también estaba bien, permite la conexión al CDN
    policy.connect_src :self, :https, "https://ga.jspm.io"
  end

  # Por ahora, podemos ignorar la generación de nonces
  # config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
  # config.content_security_policy_nonce_directives = %w(script-src style-src)
end
