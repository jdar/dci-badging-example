#TODO: make the next_controller throw warnings instead of errors for
# warning messages.
AfterStep("~@intentional_errors") do |scenario|
  found = page.first("#error_flash_div")
  found = nil if found && found.text =~ /at this time/

  #If this scenario is intended to test errors, 
  #ignore this failure by adding '@intentional_errors'
  #to the top of the file. (first line)
  raise found.text if found
end
