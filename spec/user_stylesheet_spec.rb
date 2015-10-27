require 'spec_helper'

describe UserStylesheet do
  before do
    @environment = Sprockets::Environment.new
    @environment.append_path('spec/fixtures')
  end

  def default_params
    {
      env: @environment,
      scss_variables:
      {
        background_color: 'red',
        font_color: 'white',
        font_size: '30px'
      },
      file_info:
      {
        file_name: 'testfile',
        template_file_path: 'spec/fixtures/template.scss.erb',
        tmp_dir: 'spec/fixtures'
      }
    }
  end

  it 'compiles scss to css' do
    sheet = UserStylesheet.new(default_params)
    file = sheet.compile
    expect(file.read).to eq(".container{background-color:red}.user-name{color:#fff;font-size:30px}\n")
  end


  after do
    File.delete('spec/fixtures/testfile.css') if File.exists?('spec/fixtures/testfile.css')
  end
end
