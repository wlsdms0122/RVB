
XCODE_TEMPLATE_DIRECTORY = "#{Dir.home}/Library/Developer/Xcode/Templates/File Templates/RVB"
SCRIPT_DIRECTORY = __dir__

def installTemplates()
    if Dir.exist?(XCODE_TEMPLATE_DIRECTORY)
        puts "📤 Uninstall RVB templates..."
        `rm -rf '#{XCODE_TEMPLATE_DIRECTORY}'`
    end

    puts "📥 Install RVB templates..."
    `mkdir -p '#{XCODE_TEMPLATE_DIRECTORY}'`
    `cp -R '#{SCRIPT_DIRECTORY}/RVB.xctemplate' '#{XCODE_TEMPLATE_DIRECTORY}'`

    puts "✅ Install completed!"
end

installTemplates()
