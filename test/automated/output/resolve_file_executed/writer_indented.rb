require_relative '../../automated_init'

context "Output" do
  context "Resolve File Executed" do
    context "Writer Is Indented" do
      file = Controls::Events::FileExecuted.file

      context do
        file_executed = Controls::Events::FileExecuted.example(file:)

        context "Styling Enabled" do
          output = Output.new

          output.writer.set_styling

          output.writer.increase_indentation
          comment "Writer indented"

          output.resolve(
            file_executed,
            Controls::Status.example
          )

          context "Printed" do
            control_text = "  \e[3mRan #{file}\e[m\n"

            comment "Printed Text:", output.writer.written_text
            detail "Control Text:", control_text

            test do
              assert(output.writer.written?(control_text))
            end
          end
        end

        context "Styling Disabled" do
          output = Output.new

          output.writer.increase_indentation
          comment "Writer indented"

          output.resolve(
            file_executed,
            Controls::Status.example
          )

          context "Printed" do
            control_text = "  Ran #{file}\n"

            comment "Printed Text:", output.writer.written_text
            detail "Control Text:", control_text

            test do
              assert(output.writer.written?(control_text))
            end
          end
        end
      end

      context "No Result" do
        result = Session::Result.none
        file_executed = Controls::Events::FileExecuted.example(file:, result:)

        output = Output.new

        output.writer.set_styling

        output.writer.increase_indentation
        comment "Writer indented"

        output.resolve(
          file_executed,
          Controls::Status.example
        )

        context "Printed" do
          control_text = "  \e[3mRan #{file} \e[2m(no tests)\e[m\n"

          comment "Printed Text:", output.writer.written_text
          detail "Control Text:", control_text

          test do
            assert(output.writer.written?(control_text))
          end
        end
      end
    end
  end
end
