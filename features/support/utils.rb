# this is a class for common utilities
class Utils
  def self.log_message(message)
    puts(message)
  end

  def self.wait_post_ui_action
    sleep ENV["WAIT_TIME_FOR_DATA_DISPLAY"].to_i
  end

  def self.move_old_screenshots
    Dir["screenshots/*.png"].collect.each do |file|
      FileUtils.move file, "screenshots/old"
    end
  end
end
