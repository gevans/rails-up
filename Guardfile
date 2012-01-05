guard 'spork', :cucumber => false, :test_unit => false do
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb')
end

guard 'bundler' do
  watch('Gemfile')
end

guard 'rspec', :version => 2, :cli => '-f nested --drb' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end
