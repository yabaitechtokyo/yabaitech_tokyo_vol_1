require 'yaml'
require 'pathname'
require 'optparse'

STACK       = "stack"
ENVIRONMENT = "env"
CODE        = "code"
DUMP        = "dump"
VMEXEC      = "exec"
FUNCPREFIX  = "get_"
RET         = "ret"
TRANSPRIM = "transform_primitive"

DESTRUCTURING_RULES = {
  "int" => lambda {|v| "IntegerConstant(#{v})"},
  "bool" => lambda {|v| "BooleanConstant(#{v})"},
  "context" => lambda {|v| "Context(#{v})"},
  "float" => lambda {|v| "FloatConstant(#{v})"},
  "horz" => lambda {|v| "Horz(#{v})"},
  "vert" => lambda {|v| "Vert(#{v})"},
  "length" => lambda {|v| "LengthConstant(#{v})"},
  "math" => lambda {|v| "MathValue(#{v})"},
  "path_value" => lambda {|v| "PathValue(#{v})"},
  "prepath" => lambda {|v| "PrePathValue(#{v})"},
  "regexp" => lambda {|v| "RegExpConstant(#{v})"},
}

def default_false b
  if b == nil then false else b end
end

def gen_prims tag
  YAML.load_stream(ARGF.read) do |inst|
    if default_false(inst[tag]) && inst["name"] != nil then

      puts "[ ] #{inst["name"]}"

    end
  end
end

def gen_pdf_mode_prims
  gen_prims("is-pdf-mode-primitive")
end

def gen_text_mode_prims
  gen_prims("is-text-mode-primitive")
end

opt = OptionParser.new

func = nil

opt.on('--gen-pdf-mode-prims') {|v| func = method(:gen_pdf_mode_prims) }
opt.on('--gen-text-mode-prims') {|v| func = method(:gen_text_mode_prims) }

opt.parse!(ARGV)

func.call
