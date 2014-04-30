defmodule ExJiebaTest do
  @text "小明硕士毕业于中国科学院计算所，后在日本京都大学深造"
  use ExUnit.Case

  test "MPSegment" do
    ExJieba.MPSegment.init
    assert ExJieba.MPSegment.cut(@text) == ["小", "明", "硕士", "毕业", "于", "中国科学院", "计算所", "，", "后", "在", "日本京都大学", "深造"]
  end

  test "HMMSegment" do
    ExJieba.HMMSegment.init
    assert ExJieba.HMMSegment.cut(@text) == ["小明", "硕士", "毕业于", "中国", "科学院", "计算所", "，", "后", "在", "日", "本", "京", "都", "大", "学", "深", "造"]
  end

  test "MixSegment" do
    ExJieba.MixSegment.init
    assert ExJieba.MixSegment.cut(@text) == ["小明", "硕士", "毕业", "于", "中国科学院", "计算所", "，", "后", "在", "日本京都大学", "深造"]
  end

  test "QuerySegment" do
    ExJieba.QuerySegment.init
    assert ExJieba.QuerySegment.cut(@text) == ["小明", "硕士", "毕业", "于", "中国", "中国科学院", "科学", "科学院", "学院", "计算所", "，", "后", "在", "日本", "日本京都大学", "京都", "京都大学", "大学", "深造"]
  end
end
