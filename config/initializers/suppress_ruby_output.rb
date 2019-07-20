# frozen_string_literal: true

def suppress_output
  begin
    original_stderr = $stderr.clone
    original_stdout = $stdout.clone
    $stderr.reopen(File.new("/dev/null", "w"))
    $stdout.reopen(File.new("/dev/null", "w"))
    retval = yield
  rescue StandardError
    $stdout.reopen(original_stdout)
    $stderr.reopen(original_stderr)
    raise
  ensure
    $stdout.reopen(original_stdout)
    $stderr.reopen(original_stderr)
  end
  retval
end
