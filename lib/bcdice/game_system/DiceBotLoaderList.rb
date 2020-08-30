# -*- coding: utf-8 -*-
# frozen_string_literal: true

require 'bcdice/game_system/DiceBotLoader'

# setGameByTitleで使用する読み込み処理のリスト
class DiceBotLoaderList
  # ゲームタイトルから該当する読み込み処理を探す
  # @param [String] gameTitle ゲームタイトル
  # @return [DiceBotLoader, nil]
  def self.find(gameTitle)
    # 前後の空白を除いておく
    strippedTitle = gameTitle.strip

    return nil if strippedTitle.empty?

    @loaders.find { |loader| loader.match?(strippedTitle) }
  end

  # ゲームタイトル別の読み込み処理の一覧
  # @return [Array<DiceBotLoader>]
  #
  # 新しいダイスボットを追加した際は、以下も追加する。
  @loaders = [
    DiceBotLoader.new(%w(Cthulhu COC)),
    DiceBotLoader.new(%w(Hieizan COCH)),
    DiceBotLoader.new(%w(Elric EL), :filenames => %w(Elric)),
    DiceBotLoader.new(%w(RuneQuest RQ)),
    DiceBotLoader.new(%w(Chill CH)),
    DiceBotLoader.new(%w(RoleMaster RM)),
    DiceBotLoader.new(%w(ShadowRun SR)),
    DiceBotLoader.new(%w(ShadowRun4 SR4)),
    DiceBotLoader.new(%w(Pendragon PD)),
    DiceBotLoader.new(/\A(?:SwordWorld|SW)\s*2\.0\z/i,
                      :filenames => %w(SwordWorld SwordWorld2_0),
                      :class => :SwordWorld2_0),
    DiceBotLoader.new(/\A(?:SwordWorld|SW)\s*2\.5\z/i,
                      :filenames => %w(SwordWorld SwordWorld2_5),
                      :class => :SwordWorld2_5),
    DiceBotLoader.new(%w(SwordWorld SW)),
    DiceBotLoader.new(%w(Arianrhod AR)),
    DiceBotLoader.new(/\A(?:Infinite\s*Fantasia|IF)\z/i,
                      :filenames => %w(InfiniteFantasia)),
    DiceBotLoader.new('WARPS'),
    DiceBotLoader.new(/\A(?:Demon\s*Parasite|DP)\z/i,
                      :filenames => %w(DemonParasite)),
    DiceBotLoader.new(/\A(?:Parasite\s*Blood|PB)\z/i,
                      :filenames => %w(DemonParasite ParasiteBlood),
                      :class => :ParasiteBlood),
    DiceBotLoader.new(/\A(?:Gun\s*Dog|GD)\z/i,
                      :filenames => %w(Gundog)),
    DiceBotLoader.new(/\A(?:Gun\s*Dog\s*Zero|GDZ)\z/i,
                      :filenames => %w(Gundog GundogZero),
                      :class => :GundogZero),
    DiceBotLoader.new(/\A(?:Tunnels\s*&\s*Trolls|TuT)\z/i,
                      :filenames => %w(TunnelsAndTrolls)),
    DiceBotLoader.new(/\A(?:Nightmare\s*Hunter[=\s]*Deep|NHD)\z/i,
                      :filenames => %w(NightmareHunterDeep)),
    DiceBotLoader.new(/\A(?:War\s*Hammer(FRP)?|WH)\z/i,
                      :filenames => %w(Warhammer)),
    DiceBotLoader.new(/\A(?:Phantasm\s*Adventure|PA)\z/i,
                      :filenames => %w(PhantasmAdventure)),
    DiceBotLoader.new(/\A(?:Chaos\s*Flare|CF)\z/i,
                      :filenames => %w(ChaosFlare)),
    DiceBotLoader.new(/\A(?:Cthulhu\s*Tech|CT)\z/i,
                      :filenames => %w(CthulhuTech)),
    DiceBotLoader.new(/\A(?:Tokumei\s*Tenkousei|ToT)\z/i,
                      :filenames => %w(TokumeiTenkousei)),
    DiceBotLoader.new(/\A(?:Shinobi\s*Gami|SG)\z/i,
                      :filenames => %w(ShinobiGami)),
    DiceBotLoader.new(/\A(?:Double\s*Cross|DX)\z/i,
                      :filenames => %w(DoubleCross)),
    DiceBotLoader.new(/\A(?:Sata\s*Supe|SS)\z/i,
                      :filenames => %w(Satasupe)),
    DiceBotLoader.new(/\A(?:Ars\s*Magica|AM)\z/i,
                      :filenames => %w(ArsMagica)),
    DiceBotLoader.new(/\A(?:Dark\s*Blaze|DB)\z/i,
                      :filenames => %w(DarkBlaze)),
    DiceBotLoader.new(/\A(?:Night\s*Wizard|NW)\z/i,
                      :filenames => %w(NightWizard)),
    DiceBotLoader.new('TORG', :filenames => %w(Torg)),
    DiceBotLoader.new(/\ATORG1.5\z/i,
                      :filenames => %w(Torg Torg1_5),
                      :class => :Torg1_5),
    DiceBotLoader.new(/\A(?:hunters\s*moon|HM)\z/i,
                      :filenames => %w(HuntersMoon)),
    DiceBotLoader.new(/\A(?:Blood\s*Crusade|BC)\z/i,
                      :filenames => %w(BloodCrusade)),
    DiceBotLoader.new(/\A(?:Meikyu\s*Kingdom|MK)\z/i,
                      :filenames => %w(MeikyuKingdom)),
    DiceBotLoader.new(/\A(?:Earth\s*Dawn|ED)\z/i,
                      :filenames => %w(EarthDawn)),
    DiceBotLoader.new(/\A(?:(?:Earth\s*Dawn|ED)3)\z/i,
                      :filenames => %w(EarthDawn EarthDawn3),
                      :class => :EarthDawn3),
    DiceBotLoader.new(/\A(?:(?:Earth\s*Dawn|ED)4)\z/i,
                      :filenames => %w(EarthDawn EarthDawn4),
                      :class => :EarthDawn4),
    DiceBotLoader.new(/\A(?:Embryo\s*Machine|EM)\z/i,
                      :filenames => %w(EmbryoMachine)),
    DiceBotLoader.new(/\A(?:Gehenna\s*An|GA)\z/i,
                      :filenames => %w(GehennaAn)),
    DiceBotLoader.new(/\A(?:Magica\s*Logia|ML)\z/i,
                      :filenames => %w(MagicaLogia)),
    DiceBotLoader.new(%w(Nechronica NC)),
    DiceBotLoader.new(/\A(?:Meikyu\s*Days|MD)\z/i,
                      :filenames => %w(MeikyuDays)),
    DiceBotLoader.new(%w(Peekaboo PK)),
    DiceBotLoader.new(/\A(?:Barna\s*Kronika|BK)\z/i,
                      :filenames => %w(BarnaKronika)),
    DiceBotLoader.new(%w(RokumonSekai2 RS2)),
    DiceBotLoader.new(/\A(?:Monotone\s*Museum|MM)\z/i,
                      :filenames => %w(MonotoneMuseum)),
    DiceBotLoader.new(/\AZettai\s*Reido\z/i, :filenames => %w(ZettaiReido)),
    DiceBotLoader.new(/\AEclipse\s*Phase\z/i,
                      :filenames => %w(EclipsePhase)),
    DiceBotLoader.new('NJSLYRBATTLE', :filenames => %w(NjslyrBattle)),
    DiceBotLoader.new(%w(ShinMegamiTenseiKakuseihen SMTKakuseihen)),
    DiceBotLoader.new('Ryutama'),
    DiceBotLoader.new('CardRanker'),
    DiceBotLoader.new('ShinkuuGakuen'),
    DiceBotLoader.new('CrashWorld'),
    DiceBotLoader.new('WitchQuest'),
    DiceBotLoader.new('BattleTech'),
    DiceBotLoader.new('Elysion'),
    DiceBotLoader.new('GeishaGirlwithKatana'),
    DiceBotLoader.new('GURPS', :filenames => %w(Gurps)),
    DiceBotLoader.new('GurpsFW'),
    DiceBotLoader.new('FilledWith'),
    DiceBotLoader.new('HarnMaster'),
    DiceBotLoader.new('Insane'),
    DiceBotLoader.new('KillDeathBusiness'),
    DiceBotLoader.new('Kamigakari'),
    DiceBotLoader.new('RecordOfSteam'),
    DiceBotLoader.new('Oukahoushin3rd'),
    DiceBotLoader.new('BeastBindTrinity'),
    DiceBotLoader.new('BloodMoon'),
    DiceBotLoader.new('Utakaze'),
    DiceBotLoader.new('EndBreaker'),
    DiceBotLoader.new('KanColle'),
    DiceBotLoader.new('GranCrest'),
    DiceBotLoader.new('HouraiGakuen'),
    DiceBotLoader.new('TwilightGunsmoke'),
    DiceBotLoader.new('Garako'),
    DiceBotLoader.new('ShoujoTenrankai'),
    DiceBotLoader.new('GardenOrder'),
    DiceBotLoader.new('DarkSouls'),
    DiceBotLoader.new('SterileLife'),
    DiceBotLoader.new('Paradiso'),
    DiceBotLoader.new('SamsaraBallad'),
    DiceBotLoader.new('GoblinSlayer'),
    DiceBotLoader.new('RyuTuber'),
    DiceBotLoader.new('None', :filenames => [], :class => :DiceBot)
  ]
end
