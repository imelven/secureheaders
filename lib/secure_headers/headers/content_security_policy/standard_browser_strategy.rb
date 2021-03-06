module SecureHeaders
  class ContentSecurityPolicy
    class StandardBrowserStrategy < BrowserStrategy
      def base_name
        if (browser.firefox? && browser.version.to_i >= 23) || (browser.chrome? && browser.version.to_i >= 25)
          SecureHeaders::ContentSecurityPolicy::STANDARD_HEADER_NAME
        else
          SecureHeaders::ContentSecurityPolicy::WEBKIT_CSP_HEADER_NAME
        end
      end

      def add_missing_extension_values
        directives.each do |directive|
          next unless config[directive]
          if !config[directive].include?('chrome-extension:')
            config[directive] << 'chrome-extension:'
          end
        end
      end
    end
  end
end
