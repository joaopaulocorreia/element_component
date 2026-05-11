# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Pagination do
  describe "default pagination" do
    subject { ElementComponent::Components::Pagination.new }

    it "has the correct element name" do
      expect(subject.element).to eq("nav")
    end

    it "has aria-label attribute" do
      expect(subject.attributes[:"aria-label"]).to eq(["Pagination"])
    end

    it "renders empty pagination" do
      expect(subject.render).to eq('<nav aria-label="Pagination"><ul class="pagination"></ul></nav>')
    end
  end

  describe "with size" do
    it "renders sm pagination" do
      pager = ElementComponent::Components::Pagination.new(size: :sm)
      expect(pager.render).to include("pagination-sm")
    end

    it "renders lg pagination" do
      pager = ElementComponent::Components::Pagination.new(size: :lg)
      expect(pager.render).to include("pagination-lg")
    end
  end

  describe "PageItem" do
    describe "default item" do
      subject { ElementComponent::Components::PageItem.new }

      it "has the correct element name" do
        expect(subject.element).to eq("li")
      end

      it "has page-item class" do
        expect(subject.attributes[:class]).to include("page-item")
      end
    end

    describe "active page" do
      it "renders active page" do
        item = ElementComponent::Components::PageItem.new(active: true)
        item.add_content("2")
        expect(item.render).to include('class="page-item active"')
        expect(item.render).to include('aria-current="page"')
      end
    end

    describe "disabled page" do
      it "renders disabled page" do
        item = ElementComponent::Components::PageItem.new(disabled: true)
        item.add_content("Prev")
        expect(item.render).to include('class="page-item disabled"')
        expect(item.render).to include('tabindex="-1"')
      end
    end
  end

  describe "pagination with items" do
    subject do
      ElementComponent::Components::Pagination.new do
        add_content(ElementComponent::Components::PageItem.new { add_content("1") })
      end
    end

    it "renders pagination" do
      html = subject.render
      expect(html).to start_with('<nav aria-label="Pagination">')
      expect(html).to include('<ul class="pagination">')
      expect(html).to include('<li class="page-item"><a class="page-link" href="#">1</a></li>')
      expect(html).to end_with("</ul></nav>")
    end
  end
end
