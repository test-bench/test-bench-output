require_relative '../automated_init'

context "Output" do
  context "Resolve File Not Found" do
    file = Controls::Events::FileNotFound.file
    file_not_found = Controls::Events::FileNotFound.example(file:)

    context "Styling Enabled" do
      output = Output.new

      output.writer.set_styling

      output.resolve(
        file_not_found,
        Controls::Status.example
      )

      context "Printed" do
        control_text = <<~TEXT
        \e[31mFile not found: \e[1m#{file}\e[m
        \e[m
        TEXT

        comment "Printed Text:", output.writer.written_text
        detail "Control Text:", control_text

        test do
          assert(output.writer.written?(control_text))
        end
      end
    end

    context "Styling Disabled" do
      output = Output.new

      output.resolve(
        file_not_found,
        Controls::Status.example
      )

      context "Printed" do
        control_text = <<~TEXT
        File not found: #{file}

        TEXT

        comment "Printed Text:", output.writer.written_text
        detail "Control Text:", control_text

        test do
          assert(output.writer.written?(control_text))
        end
      end
    end
  end
end
