class UserStylesheet
  attr_reader :env, :scss_variables, :file_info, :scss_info, :scss_file

  def initialize(env:, scss_variables:, file_info:, scss_info: {})
    @env = env
    @scss_variables = OpenStruct.new(scss_variables)
    @file_info = file_info
    @scss_info = scss_info.empty? ? default_scss_info : scss_info
  end

  def compile
    overwrite_scss
    File.write(scss_file.path, render_css)
    newpath = File.join(file_info[:tmp_dir], "#{file_info[:file_name]}.css")
    File.rename(scss_file.path, newpath)
    File.new(newpath)
  end

  private

  def default_scss_info
    {
      syntax: :scss,
      cache: false,
      read_cache: false,
      style: :compressed
    }
  end

  def overwrite_scss
    template_body = ERB.new(File.read(File.expand_path(file_info[:template_file_path]))).result(binding)
    @scss_file = File.open(scss_file_path, 'w') { |f| f.write(template_body); f.flush }
  end

  def scss_file_dir
    @scss_file_path ||= File.expand_path(file_info[:tmp_dir])
  end

  def scss_file_path
    @scss_file_path ||= File.join(scss_file_dir, "#{file_info[:file_name]}.scss")
  end

  def render_css
    Sass::Engine.new(asset_source, scss_info).render
  end

  def asset_source
    if env.find_asset(file_info[:file_name])
      env.find_asset(file_info[:file_name]).source
    else
      unloaded_asset
    end
  end

  def unloaded_asset
    uri = Sprockets::URIUtils.build_asset_uri(scss_file.path, type: 'text/css')
    asset = Sprockets::UnloadedAsset.new(uri, env)
    env.load(asset.uri).source
  end
end
