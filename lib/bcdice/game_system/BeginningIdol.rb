# frozen_string_literal: true

require 'bcdice/game_system/beginning_idol/table'

module BCDice
  module GameSystem
    class BeginningIdol < Base
      # ゲームシステムの識別子
      ID = 'BeginningIdol'

      # ゲームシステム名
      NAME = 'ビギニングアイドル'

      # ゲームシステム名の読みがな
      SORT_KEY = 'ひきにんくあいとる'

      # ダイスボットの使い方
      HELP_MESSAGE = <<~INFO_MESSAGE_TEXT
        ・パフォーマンス　[r]PDn[+m/-m](r：場に残った出目　n：振る数　m：修正値)
        ・ワールドセッティング仕事表　BWT：大手芸能プロ　LWT：弱小芸能プロ
        　TWT：ライブシアター　CWT：アイドル部　LO[n]：地方アイドル(n：チャンス)
        　SU：情熱の夏　WI：ぬくもりの冬　NA：大自然　GA：女学園　BA：アカデミー
        ・仕事表　WT　VA：バラエティ　MU：音楽関係　DR：ドラマ関係
        　VI：ビジュアル関係　SP：スポーツ　CHR：クリスマス　PAR：パートナー関係
        　SW：お菓子　AN：動物　MOV：映画　FA：ファンタジー
        ・ランダムイベント　RE
        ・ハプニング表　HA
        ・特技リスト　AT[n](n：分野No.)
        ・アイドルスキル修得表　SGT：チャレンジガールズ　RS：ロードトゥプリンス
        ・変調　BT[n](n：発生数)
        ・アイテム　IT[n](n：獲得数)
        ・アクセサリー　ACT：種別決定　ACB：ブランド決定　ACE：効果表
        ・衣装　DT：チャレンジガールズ　RC：ロードトゥプリンス　FC:フォーチュンスターズ
        ・無茶ぶり表　LUR：地方アイドル　SUR：情熱の夏　WUR：ぬくもりの冬
        　NUR：大自然　GUR：女学園　BUR：アカデミー
        ・センタールール　HW：向かい風シーン表　FL：駆け出しシーン表　LN：孤独表
        　マイスキル【MS：名前決定　MSE：効果表】　演出表【ST　FST：ファンタジー】
        ・合宿ルール　散策表【SH：ショッピングモール　MO：山　SEA：海　SPA：温泉街】
        　TN：夜語りシチュエーション表　成長表【CG：コモン　GG：ゴールド】
        ・サビ表　CHO　SCH：情熱の夏　WCH：ぬくもりの冬　NCH：大自然
        　GCH：女性向け　PCH：力強い
        ・キャラ空白表　CBT：チャレンジガールズ　RCB：ロードトゥプリンス
        ・趣味空白表　HBT：チャレンジガールズ　RHB：ロードトゥプリンス
        ・マスコット暴走表　RU
        ・アイドル熱湯風呂　nC：バーストタイム(n：温度)　BU：バースト表
        ・攻撃　n[S]A[r][+m/-m](n：振る数　S：失敗しない　r：取り除く出目　m：修正値)
        ・かんたんパーソン表　SIP
        ・会場表
        　BVT：大手芸能プロ　LVT：弱小芸能プロ　TVT：ライブシアター　CVT：アイドル部
        ・場所表
        　BST：大手芸能プロ　LST：弱小芸能プロ　TST：ライブシアター　CST：アイドル部
        ・プレッシャー種別決定表
        　BPT：大手芸能プロ　LPT：弱小芸能プロ　TPT：ライブシアター　CPT：アイドル部
        ・道具表
        　BIT：大手芸能プロ　LIT：弱小芸能プロ　TIT：ライブシアター　CIT：アイドル部
        []内は省略可　D66入れ替えあり
      INFO_MESSAGE_TEXT

      register_prefix(
        SKILL_TABLE.prefixes,
        'IT',
        'BT',
        '\d{2}C',
        '\d+S?A',
        '[1-7]*PD'
      )

      def initialize(command)
        super(command)

        @sort_add_dice = true
        @d66_sort_type = D66SortType::ASC
      end

      def result_nd6(total, dice_total, _value_list, cmp_op, target)
        return nil if target == '?'
        return nil unless cmp_op == :>=

        if dice_total <= 2
          Result.fumble(translate("BeginningIdol.fumble"))
        elsif dice_total >= 12
          Result.critical(translate("BeginningIdol.special"))
        elsif total >= target
          Result.success(translate("success"))
        else
          Result.failure(translate("failure"))
        end
      end

      alias check_2D6 check_nD6

      def eval_game_system_specific_command(command)
        roll_attack(command) ||
          roll_burst(command) ||
          roll_performance(command) ||
          self.class::SKILL_TABLE.roll_command(@randomizer, command) ||
          self.class::ITEM_TABLE.roll_command(@randomizer, command) ||
          self.class::BAD_STATUS_TABLE.roll_command(@randomizer, command) ||
          self.class::LOCAL_WORK_TABLE.roll_command(@randomizer, command) ||
          roll_tables(command, self.class::TABLES)
      end

      private

      def roll_burst(command)
        m = /^(\d{2})C$/.match(command)
        unless m
          return nil
        end

        degrees = m[1].to_i
        if (degrees < 45) || (degrees > 55)
          return nil
        end

        counts =
          if degrees <= 49
            3
          elsif degrees <= 52
            4
          elsif degrees <= 54
            5
          else
            6
          end

        dice_list = @randomizer.roll_barabara(counts, 6).sort
        total = dice_list.sum() + degrees

        result =
          if total >= 80
            translate("BeginningIdol.burst.burst")
          elsif total >= 75
            translate("BeginningIdol.burst.critical_success")
          elsif total >= 65
            translate("BeginningIdol.burst.success")
          else
            translate("failure")
          end

        name = translate("BeginningIdol.burst.name")
        return "#{name} ＞ #{degrees}+[#{dice_list.join(',')}] ＞ #{total} ＞ #{result}"
      end

      def roll_attack(command)
        m = /^(\d+)(S?)A([1-6]*)([+\-]\d+)?$/.match(command)
        unless m
          return nil
        end

        counts = m[1].to_i
        return nil if counts <= 0

        sure = !m[2].empty?
        remove = m[3].each_char.map(&:to_i)
        adjust = m[4].to_i
        adjust_str = Format.modifier(adjust)

        dice = @randomizer.roll_barabara(counts, 6).sort
        dice_str = dice.join(",")

        dice -= remove

        text = "#{translate('BeginningIdol.attack.name')} ＞ [#{dice_str}]#{adjust_str} ＞ "

        unless (dice.count == counts) || dice.empty?
          text += "[#{dice.join(',')}]#{adjust_str} ＞ "
        end

        if sure || (dice.count == dice.uniq.count)
          total = [dice.sum() + adjust.to_i, 0].max
          text += format(translate('BeginningIdol.attack.damage'), total: total)
        else
          text += translate('failure')
        end
        return text
      end

      def roll_performance(command)
        m = /^([1-7]*)PD(\d+)([+\-]\d+)?$/.match(command)
        unless m
          return nil
        end

        counts = m[2].to_i
        return nil if counts <= 0

        carry = m[1].chars.map(&:to_i).sort
        modifier = m[3].to_i

        dice_list = @randomizer.roll_barabara(counts, 6).sort
        all_dice = (dice_list + carry).sort
        filtered = select_uniqs(all_dice)

        title = carry.empty? ? translate("BeginningIdol.PD.paformance") : translate("BeginningIdol.PD.symphony")

        result =
          if carry.empty?
            result_performance(filtered, modifier, all_dice)
          else
            result_symphony(filtered, modifier)
          end

        sequence = [
          title,
          format_dice_list(dice_list, carry, modifier),
          result,
        ]

        return sequence.join(" ＞ ")
      end

      def select_uniqs(dice_list)
        dice_list.group_by(&:itself).to_a
                 .select { |_, arr| arr.size == 1 }
                 .map { |dice, _| dice }
                 .sort
      end

      def format_dice_list(dice_list, carry, modifier)
        if carry.empty?
          "[#{dice_list.join(',')}]#{Format.modifier(modifier)}"
        else
          "[#{dice_list.join(',')}],[#{carry.join(',')}]#{Format.modifier(modifier)}"
        end
      end

      def result_performance(list, modifier, all_list)
        if list.empty?
          format(translate("BeginningIdol.PD.miracle"), value: modifier + 10)
        elsif list == [1, 2, 3, 4, 5, 6]
          format(translate("BeginningIdol.PD.perfect_miracle"), value: modifier + 30)
        elsif list.size != all_list.size
          "[#{list.join(',')}]#{Format.modifier(modifier)} ＞ #{list.sum() + modifier}"
        else
          (list.sum() + modifier).to_s
        end
      end

      def result_symphony(list, modifier)
        if list.empty?
          format(translate("BeginningIdol.PD.miracle_synchro"), value: modifier + 15)
        elsif list == [1, 2, 3, 4, 5, 6]
          perfect_miracle = format(translate("BeginningIdol.PD.perfect_miracle"), value: modifier + 30)
          "[#{list.join(',')}]#{Format.modifier(modifier)} ＞ #{perfect_miracle}"
        else
          "[#{list.join(',')}]#{Format.modifier(modifier)} ＞ #{list.sum() + modifier}"
        end
      end
    end
  end
end
