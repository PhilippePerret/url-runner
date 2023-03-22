=begin

  * Ouvrir un terminal à ce dossier
  * jouer 'puma -C ./config.rb ./runner.ru'
  * En rejoignant l'adresse 'http://localhost:1111' on appelle la méthode HelloWord#call


=end
require "addressable/uri"

class TaskRunner
  attr_reader :env
  attr_reader :params
  attr_reader :result # résultat du script
  def call(env)
    parse_query_string(env)
    # puts "env = #{env.inspect}"
   [200, { 'Content-Type' => 'text/html; charset=utf-8', 'Content-Length' => body.length.to_s }, [body]]
  end

  def parse_query_string(env)
    @env = env
    url = Addressable::URI.parse("?#{env['QUERY_STRING']}")
    @params = url.query_values
    if @params.key?('script')
      run_script_if_exists(params['script'])
    end
  end

  def run_script_if_exists(script)
    script_path = File.join(__dir__,'scripts',"#{script}.rb")
    if File.exist?(script_path)
      require script_path
      send(script.to_sym, params['args'])
      @result = "Script exécuté avec succès."
    else
      @result = "Le script #{script} est introuvable"
    end
  end

  def body
    <<~HTML
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>Runner de tâche</title>
    </head>
    <body>
      <div>Params transmis : #{params.inspect}</div>
      <div>Résultat de l'opération : #{result}</div>
    </body>
    </html>
    HTML
  end
end


run TaskRunner.new
