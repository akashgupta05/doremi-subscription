require 'spec_helper'
require_relative '../../../../lib/enums/subscription_category'
require_relative '../../../../lib/enums/subscription_plan'
require_relative '../../../../lib/models/podcast/free_subscription'
require_relative '../../../../lib/models/music/personal_subscription'
require_relative '../../../../lib/models/video/premium_subscription'
require_relative '../../../../lib/models/factories/subscription_factory'
require_relative '../../../../lib/models/factories/podcast_subscription_factory'
require_relative '../../../../lib/models/factories/music_subscription_factory'
require_relative '../../../../lib/models/factories/video_subscription_factory'

RSpec.describe SubscriptionFactory do
  describe '.subscription_category_factory' do
    it 'returns a PodcastSubscriptionFactory instance for the podcast subscription category' do
      factory = SubscriptionFactory.subscription_category_factory(SubscriptionCategory::PODCAST)
      expect(factory).to be_an_instance_of(PodcastSubscriptionFactory)
    end

    it 'returns a MusicSubscriptionFactory instance for the music subscription category' do
      factory = SubscriptionFactory.subscription_category_factory(SubscriptionCategory::MUSIC)
      expect(factory).to be_an_instance_of(MusicSubscriptionFactory)
    end

    it 'returns a VideoSubscriptionFactory instance for the video subscription category' do
      factory = SubscriptionFactory.subscription_category_factory(SubscriptionCategory::VIDEO)
      expect(factory).to be_an_instance_of(VideoSubscriptionFactory)
    end

    it 'returns nil for an invalid subscription category' do
      factory = SubscriptionFactory.subscription_category_factory('invalid')
      expect(factory).to be_nil
    end
  end

  describe '.subscription' do
    context 'when given a valid subscription category and plan' do
      it 'returns a FreeSubscription instance for the podcast subscription category and free plan' do
        subscription = SubscriptionFactory.subscription(SubscriptionCategory::PODCAST, SubscriptionPlan::FREE)
        expect(subscription).to be_an_instance_of(Podcast::FreeSubscription)
      end

      it 'returns a PersonalSubscription instance for the music subscription category and personal plan' do
        subscription = SubscriptionFactory.subscription(SubscriptionCategory::MUSIC, SubscriptionPlan::PERSONAL)
        expect(subscription).to be_an_instance_of(Music::PersonalSubscription)
      end

      it 'returns a PremiumSubscription instance for the video subscription category and premium plan' do
        subscription = SubscriptionFactory.subscription(SubscriptionCategory::VIDEO, SubscriptionPlan::PREMIUM)
        expect(subscription).to be_an_instance_of(Video::PremiumSubscription)
      end
    end

    context 'when given an invalid subscription category or plan' do
      it 'raises an error for an invalid subscription category' do
        expect {
          SubscriptionFactory.subscription('invalid', SubscriptionPlan::FREE)
        }.to raise_error('Invalid Subscription Category')
      end

      it 'raises an error for an invalid subscription plan' do
        expect {
          SubscriptionFactory.subscription(SubscriptionCategory::PODCAST, 'invalid')
        }.to raise_error('Invalid Subscription Plan')
      end
    end
  end
end
