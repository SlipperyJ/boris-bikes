require 'docking_station'

describe DockingStation do

  context 'responds to' do

    it { is_expected.to respond_to :release_bike }

    it "should raise an error when there are no bikes" do
      expect { subject.release_bike }.to raise_error("No bikes docked")
    end

    it "should release a bike which has been docked before" do
      bike = Bike.new
      subject.dock(bike)
      expect(subject.release_bike).to eq bike
      expect(bike.working).to be true
    end
  end

  context "docking the bike" do

    it "should respond to 'dock' and check status" do
      expect(subject).to respond_to(:dock).with(2).argument
      #bike = [Bike.new]
      #expect(subject.dock(bike)).to eq bike
    end

    it "should be able to see the bike" do
      bike = [Bike.new]
      subject.dock(bike[0])
      expect(subject.bikes).to eq bike
    end

    it "should raise an error when the docking station is full" do
      bike = Bike.new
      DockingStation::DEFAULT_CAPACITY.times { subject.dock(bike) }
      expect { subject.dock(bike) }.to raise_error("docking station full")
    end

    it "should be able to report the bike as not woring" do
      bike = Bike.new
      subject.dock(bike, false)
      expect(bike.working).to eq false
    end
  end

  context "capacity" do

    it "can be changed on initialize" do
      station = DockingStation.new(30)
      expect(station.capacity).to eq 30
    end

    it "should default to 20" do
      expect(subject.capacity).to eq 20

    end
  end
end
