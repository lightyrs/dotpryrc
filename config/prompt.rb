# with AWS:
#             AWS@3.0.0 (main)>
# with Rails:
#             3.2.13@2.0.0 (main)>
# Plain Ruby:
#             2.0.0 (main)>

Pry.config.prompt = proc do |obj, level, _|
  prompt = ""

  prompt << "AWS@" if defined?(AWS)
  prompt << "#{Rails.version}@" if defined?(Rails)
  prompt << "#{RUBY_VERSION}"

  "#{prompt} (#{obj})> "
end
