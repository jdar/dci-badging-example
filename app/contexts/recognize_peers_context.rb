class RecognizePeersContext
  extend Surrounded::Context
  protect_triggers

  initialize_without_keywords :mentor, :badges, :peers

  role :mentor do
    def can_recognize?(badge, user)
      return false if user.badges.include?(badge)
      true
    end
  end

  role :peers do
    def select_badges_that_can_be_recognized_for_all(badges)
      badges.collect do |badge|
        badge if reduce(true) do |bool, user|
          bool = bool && mentor.can_recognize?(badge,user)
          if block_given?
            bool && yield(badge, bool)
          else
            bool
          end
        end
      end.compact
    end

    def select_badges_that_can_be_recognized_for_any(badges)
      badges.collect do |badge|
        badge if reduce(false) do |bool, user|
          bool = bool || mentor.can_recognize?(badge,user)
          if block_given?
            bool || yield(badge, bool)
          else
            bool
          end
        end
      end.compact
    end
  end

  trigger def recognize_all
    recognitions = Recognition.create(
      peers.flat_map do |user|
        badges.collect do |badge|
          {badge: badge, user: user}
        end
      end
    )

    for r in recognitions.compact
      r.user.account += r.badge.points
    end

    #TODO: rails is smart enough to only hit the database users.length times.
    #careful, though. It will still call extra callbacks.
    recognitions.group_by(&:user).keys.each(&:save)
  end

  trigger def badges_that_can_be_recognized_for_all
    peers.select_badges_that_can_be_recognized_for_all(badges)
  end

  trigger def badges_that_can_be_recognized_for_any
    peers.select_badges_that_can_be_recognized_for_any(badges)
  end 
end
