class TestManager
  def self.add_tear_down(block)
    tear_down_callbacks << block
  end

  # All the callback which run at scenario teardown
  #
  def self.tear_down_callbacks
    @tear_down_callbacks ||= []
  end
  private_class_method :tear_down_callbacks

  # Init data before each scenario
  def self.run_up
    @tear_down_callbacks = nil
    @last_tick = Time.now
  end

  # Teardown action, run at cucumber `after` hook
  def self.tear_down
    tear_down_callbacks.each do|block|
      block.call
    end
    @tear_down_callbacks = nil
  end

  # Log all failed scenario
  #
  def self.failed_scenarios
    @failed_scenarios ||= []
  end
  private_class_method :failed_scenarios

  # Track scenario after run
  # if rerun enabled, remove from list if rerun passed
  #
  def self.track_scenario(scenario)
    scenario_location = scenario.location.to_s
    if scenario.failed?
      unless failed_scenarios.include?(scenario_location)
        failed_scenarios << scenario_location
      end
    else
      failed_scenarios.delete(scenario_location)
    end
  end

  # Take snapshot if scenario failed
  #
  def self.take_snapshot(scenario, page, report_dir)
    if scenario.failed?
      page.save_screenshot "#{report_dir}/#{DateTime.now.to_i}-#{scenario.name.parameterize}.png"
    end
  end

# Ticker runs after each step, to track running of each step only
  #
  def self.step_tick
    tick = Time.current
    puts "\tStep running time: #{(tick - @last_tick).round(2)}"
    @last_tick = tick
  end

end