#property copyright "HFT SantosFX"
#property link      "RealsantosFX"
#property version   "2.00"
#property strict
#include <stdlib.mqh>
#include <WinUser32.mqh>
#include <ChartObjects\ChartObjectsTxtControls.mqh>

#define BullColor Green //DodgerBlue
#define BearColor Red  //FireBrick

enum dbu {Constant=0,OneMinute=1,FiveMinutes=5};
//string   Pairs ="AUDCAD,AUDCHF,AUDJPY,AUDNZD,AUDUSD,CADCHF,CADJPY,CHFJPY,EURAUD,EURCAD,EURCHF,EURGBP,EURJPY,EURNZD,EURUSD,GBPAUD,GBPCAD,GBPCHF,GBPJPY,GBPNZD,GBPUSD,NZDCAD,NZDCHF,NZDJPY,NZDUSD,USDCAD,USDCHF,USDJPY";

//===========================================================================================================
   string                    t_trade                     = "EXPERT MANAGEMENT";//AUTO TRADE =================
   bool                      UseDefaultPairs             = true     ;// Use all 15 pairs
   string                    OwnPairs                    = "XAUUSD" ;// Use your own pairs
   dbu                       DashUpdate                  = 0        ;// Updating 0,1,5 
   int                       Magic_Number                = 1981     ;// Magic Number
   bool                      autotrade                   = true     ;// Automatic Trades 
//===========================================================================================================
   string                    t_triggerSTR                = "TRIGGER MANAGEMENT";//STR =======================
   input   ENUM_TIMEFRAMES   period_STR                  = 10080     ;//STR DASH   
//===========================================================================================================
   /*input*/   string            t_triggerBD1                = "TRIGGER MANAGEMENT";//BID RATIO AJUSTE 1 ========
   bool                      trigger_use_bidratio00       = false     ;//Use BidRatio filtro
   input   ENUM_TIMEFRAMES   periodBR00                   = 1       ;//TimeFrame BidRatio
   input   double            trigger_buy_bidratio00       = 60       ;//% Level to open long
   sinput  double            trade_MIN_buy_bidratio00     = 60       ;//Minimum opening adjustment
   sinput  double            trade_MAX_buy_bidratio00     = 97       ;//Maximum opening adjustment     
   input   double            trigger_sell_bidratio00      = -60       ;//% Level to open short
   sinput  double            trade_MIN_sell_bidratio00    = -60      ;//Minimum opening adjustment
   sinput  double            trade_MAX_sell_bidratio00    = -97      ;//Maximum opening adjustment 
//===============   
   bool                      trigger_use_bidratio11       = false     ;//Use BidRatio filtro
   input   ENUM_TIMEFRAMES   periodBR11                   = 5       ;//TimeFrame BidRatio
   input   double            trigger_buy_bidratio11       = 60       ;//% Level to open long
   sinput  double            trade_MIN_buy_bidratio11     = 60       ;//Minimum opening adjustment
   sinput  double            trade_MAX_buy_bidratio11     = 97       ;//Maximum opening adjustment      
   input   double            trigger_sell_bidratio11      = -60       ;//% Level to open short
   sinput  double            trade_MIN_sell_bidratio11    = -60      ;//Minimum opening adjustment
   sinput  double            trade_MAX_sell_bidratio11    = -97      ;//Maximum opening adjustment    
//===============   
   bool                      trigger_use_bidratio22       = false     ;//Use BidRatio filtro
   input   ENUM_TIMEFRAMES   periodBR22                   = 15       ;//TimeFrame BidRatio
   input   double            trigger_buy_bidratio22       = 60       ;//% Level to open long
   sinput  double            trade_MIN_buy_bidratio22     = 60       ;//Minimum opening adjustment
   sinput  double            trade_MAX_buy_bidratio22     = 97       ;//Maximum opening adjustment     
   input   double            trigger_sell_bidratio22      = -60       ;//% Level to open short
   sinput  double            trade_MIN_sell_bidratio22    = -60      ;//Minimum opening adjustment
   sinput  double            trade_MAX_sell_bidratio22    = -97      ;//Maximum opening adjustment     
//===============
   bool                      trigger_use_bidratio33       = false     ;//Use BidRatio filtro
   input   ENUM_TIMEFRAMES   periodBR33                   = 30       ;//TimeFrame BidRatio
   input   double            trigger_buy_bidratio33       = 60       ;//% Level to open long
   sinput  double            trade_MIN_buy_bidratio33     = 60       ;//Minimum opening adjustment
   sinput  double            trade_MAX_buy_bidratio33     = 97       ;//Maximum opening adjustment   
   input   double            trigger_sell_bidratio33      = -60       ;//% Level to open short
   sinput  double            trade_MIN_sell_bidratio33    = -60      ;//Minimum opening adjustment
   sinput  double            trade_MAX_sell_bidratio33    = -97      ;//Maximum opening adjustment       
//===============   
   bool                      trigger_use_bidratio44       = false     ;//Use BidRatio filtro
   input   ENUM_TIMEFRAMES   periodBR44                   = 60       ;//TimeFrame BidRatio
   input   double            trigger_buy_bidratio44       = 60       ;//% Level to open long
   sinput  double            trade_MIN_buy_bidratio44     = 60       ;//Minimum opening adjustment
   sinput  double            trade_MAX_buy_bidratio44     = 97       ;//Maximum opening adjustment       
   input   double            trigger_sell_bidratio44      = -60       ;//% Level to open short
   sinput  double            trade_MIN_sell_bidratio44    = -60      ;//Minimum opening adjustment
   sinput  double            trade_MAX_sell_bidratio44    = -97      ;//Maximum opening adjustment    
//===============
   bool                      trigger_use_bidratio55       = false     ;//Use BidRatio filtro
   input   ENUM_TIMEFRAMES   periodBR55                   = 240       ;//TimeFrame BidRatio
   input   double            trigger_buy_bidratio55       = 60       ;//% Level to open long
   sinput  double            trade_MIN_buy_bidratio55     = 60       ;//Minimum opening adjustment
   sinput  double            trade_MAX_buy_bidratio55     = 97       ;//Maximum opening adjustment     
   input   double            trigger_sell_bidratio55      = -60       ;//% Level to open short
   sinput  double            trade_MIN_sell_bidratio55    = -60      ;//Minimum opening adjustment
   sinput  double            trade_MAX_sell_bidratio55    = -97      ;//Maximum opening adjustment    
//===============
   bool                      trigger_use_bidratio66       = false     ;//Use BidRatio filtro
   input   ENUM_TIMEFRAMES   periodBR66                   = 1440       ;//TimeFrame BidRatio
   input   double            trigger_buy_bidratio66       = 60       ;//% Level to open long
   sinput  double            trade_MIN_buy_bidratio66     = 60       ;//Minimum opening adjustment
   sinput  double            trade_MAX_buy_bidratio66     = 97       ;//Maximum opening adjustment  
   input   double            trigger_sell_bidratio66      = -60       ;//% Level to open short
   sinput  double            trade_MIN_sell_bidratio66    = -60      ;//Minimum opening adjustment
   sinput  double            trade_MAX_sell_bidratio66    = -97      ;//Maximum opening adjustment     
//===============
//===========================================================================================================
   input   string            t_triggerPIPS                = "TRIGGER MANAGEMENT";//PIPS AJUSTE ========
   bool                      trigger_use_pips00       = false     ;//Use BidRatio filtro
   input   double            trigger_buy_pips00       = 1       ;//% Level to open long
   input   double            trigger_sell_pips00      = -1       ;//% Level to open short
//===============   
   bool                      trigger_use_pips11       = false     ;//Use BidRatio filtro
   input   double            trigger_buy_pips11       = 1       ;//% Level to open long
   input   double            trigger_sell_pips11      = -1       ;//% Level to open short
//===============   
   bool                      trigger_use_pips22       = false     ;//Use BidRatio filtro
   input   double            trigger_buy_pips22       = 1       ;//% Level to open long
   input   double            trigger_sell_pips22      = -1       ;//% Level to open short
//===============
   bool                      trigger_use_pips33       = false     ;//Use BidRatio filtro
   input   double            trigger_buy_pips33       = 1       ;//% Level to open long
   input   double            trigger_sell_pips33      = -1       ;//% Level to open short
//===============   
   bool                      trigger_use_pips44       = false     ;//Use BidRatio filtro
   input   double            trigger_buy_pips44       = 1       ;//% Level to open long
   input   double            trigger_sell_pips44      = -1       ;//% Level to open short
//===============
   bool                      trigger_use_pips55       = false     ;//Use BidRatio filtro
   input   double            trigger_buy_pips55       = 1       ;//% Level to open long
   input   double            trigger_sell_pips55      = -1       ;//% Level to open short
//===============
   bool                      trigger_use_pips66       = false     ;//Use BidRatio filtro
   input   double            trigger_buy_pips66       = 1       ;//% Level to open long
   input   double            trigger_sell_pips66      = -1       ;//% Level to open short
//===============                                
//===========================================================================================================
   /*input*/   string            t_triggerSTR1               = "TRIGGER MANAGEMENT";//STR AJUSTE 1 ==============   
   bool                      trigger_use_relstrength00    = false    ;//Use Relative Strength filtro (Base)//
   /*input*/   double            trigger_buy_relstrength00    = 1.0      ;//Strength to open long
   /*sinput*/  double            trade_MIN_buy_relstrength00  = 1.0      ;//Minimum opening adjustment
   /*sinput*/  double            trade_MAX_buy_relstrength00  = 10.0      ;//Maximum opening adjustment
   /*input*/   double            trigger_sell_relstrength00   = 1.0     ;//Strength to open short
   /*sinput*/  double            trade_MIN_sell_relstrength00 = 1.0     ;//Minimum opening adjustment
   /*sinput*/  double            trade_MAX_sell_relstrength00 = 10.0     ;//Maximum opening adjustment 
//===============
   bool                      trigger_use_relstrength11    = false    ;//Use Relative Strength filtro (Base)//
   /*input*/   double            trigger_buy_relstrength11    = 1.0      ;//Strength to open long
   /*sinput*/  double            trade_MIN_buy_relstrength11  = 1.0      ;//Minimum opening adjustment
   /*sinput*/  double            trade_MAX_buy_relstrength11  = 10.0      ;//Maximum opening adjustment
   /*input*/   double            trigger_sell_relstrength11   = 1.0     ;//Strength to open short
   /*sinput*/  double            trade_MIN_sell_relstrength11 = 1.0     ;//Minimum opening adjustment
   /*sinput*/  double            trade_MAX_sell_relstrength11 = 10.0     ;//Maximum opening adjustment 
//===============
   bool                      trigger_use_relstrength22    = false    ;//Use Relative Strength filtro (Base)//
   /*input*/   double            trigger_buy_relstrength22    = 1.0      ;//Strength to open long
   /*sinput*/  double            trade_MIN_buy_relstrength22  = 1.0      ;//Minimum opening adjustment
   /*sinput*/  double            trade_MAX_buy_relstrength22  = 10.0      ;//Maximum opening adjustment
   /*input*/   double            trigger_sell_relstrength22   = 1.0     ;//Strength to open short
   /*sinput*/  double            trade_MIN_sell_relstrength22 = 1.0     ;//Minimum opening adjustment
   /*sinput*/  double            trade_MAX_sell_relstrength22 = 10.0     ;//Maximum opening adjustment 
//===============
   bool                      trigger_use_relstrength33    = false    ;//Use Relative Strength filtro (Base)//
   /*input*/   double            trigger_buy_relstrength33    = 1.0      ;//Strength to open long
   /*sinput*/  double            trade_MIN_buy_relstrength33  = 1.0      ;//Minimum opening adjustment
   /*sinput*/  double            trade_MAX_buy_relstrength33  = 10.0      ;//Maximum opening adjustment 
   /*input*/   double            trigger_sell_relstrength33   = 1.0     ;//Strength to open short
   /*sinput*/  double            trade_MIN_sell_relstrength33 = 1.0     ;//Minimum opening adjustment
   /*sinput*/  double            trade_MAX_sell_relstrength33 = 10.0     ;//Maximum opening adjustment
//===============
   bool                      trigger_use_relstrength44    = false    ;//Use Relative Strength filtro (Base)//
   /*input*/   double            trigger_buy_relstrength44    = 1.0      ;//Strength to open long
   /*sinput*/  double            trade_MIN_buy_relstrength44  = 1.0      ;//Minimum opening adjustment
   /*sinput*/  double            trade_MAX_buy_relstrength44  = 10.0      ;//Maximum opening adjustment 
   /*input*/   double            trigger_sell_relstrength44   = 1.0     ;//Strength to open short
   /*sinput*/  double            trade_MIN_sell_relstrength44 = 1.0     ;//Minimum opening adjustment
   /*sinput*/  double            trade_MAX_sell_relstrength44 = 10.0     ;//Maximum opening adjustment
//===============
   bool                      trigger_use_relstrength55    = false    ;//Use Relative Strength filtro (Base)//
   /*input*/   double            trigger_buy_relstrength55    = 1.0      ;//Strength to open long
   /*sinput*/  double            trade_MIN_buy_relstrength55  = 1.0      ;//Minimum opening adjustment
   /*sinput*/  double            trade_MAX_buy_relstrength55  = 10.0      ;//Maximum opening adjustment
   /*input*/   double            trigger_sell_relstrength55   = 1.0     ;//Strength to open short
   /*sinput*/  double            trade_MIN_sell_relstrength55 = 1.0     ;//Minimum opening adjustment
   /*sinput*/  double            trade_MAX_sell_relstrength55 = 10.0     ;//Maximum opening adjustment
//===============
   bool                      trigger_use_relstrength66    = false    ;//Use Relative Strength filtro (Base)//
   /*input*/   double            trigger_buy_relstrength66    = 1.0      ;//Strength to open long
   /*sinput*/  double            trade_MIN_buy_relstrength66  = 1.0      ;//Maximum opening adjustment
   /*sinput*/  double            trade_MAX_buy_relstrength66  = 10.0      ;//Ajuste maximo para abertura 
   /*input*/   double            trigger_sell_relstrength66   = 1.0     ;//Strength to open short
   /*sinput*/  double            trade_MIN_sell_relstrength66 = 1.0     ;//Minimum opening adjustment
   /*sinput*/  double            trade_MAX_sell_relstrength66 = 10.0     ;//Maximum opening adjustment
//===============     
//===========================================================================================================   
   input   string            t_triggerADR                = "TRIGGER MANAGEMENT";//ADR AJUSTE 2 ==============   
   input   ENUM_TIMEFRAMES   periodADR                   = 1440     ;//ADR   
//===========================================================================================================       
   /*input*/   string            t_triggerPIP                = "TRIGGER MANAGEMENT";//PIP 2 =====================    
   bool                      trigger_use_Pips            = false     ;//========================  
   /*input*/   ENUM_TIMEFRAMES   periodPIP                   = 1440       ;//TimeFrame Pips 
   /*sinput*/  double            trade_MIN_pips              = 1        ;//Minimum pips to open a position
   /*sinput*/  double            trade_MAX_pips              = 300       ;//Maximum pips to open a position 
//===========================================================================================================          
   input   string            t_triggerBD2                = "TRIGGER MANAGEMENT";//BID RATIO 2 ===============   
   bool                      trigger_use_bidratio        = true    ;//Use BidRatio filtro
   input   ENUM_TIMEFRAMES   periodBR0                   = 1440       ;//TimeFrame BidRatio
   input   double            trigger_buy_bidratio        = 60       ;//% Ratio level to open long
   sinput  double            trade_MIN_buy_bidratio      = 60       ;//Minimum opening adjustment
   sinput  double            trade_MAX_buy_bidratio      = 97       ;//Maximum opening adjustment
   input   double            trigger_sell_bidratio       = 40       ;//% Ratio level to open short
   sinput  double            trade_MIN_sell_bidratio     = 40       ;//Minimum opening adjustment
   sinput  double            trade_MAX_sell_bidratio     = 3       ;//Maximum opening adjustment
//===========================================================================================================
   input   string            t_triggerBSR2               = "TRIGGER MANAGEMENT";//BUY SELL RATIO 2 ==========   
   bool                      trigger_use_buysellratio    = true     ;//Use Buy/Sell Ratio filtro
   input   double            trigger_buy_buysellratio    = 5.5      ;//Level to open BSR long
   sinput  double            trade_MIN_buy_buysellratio  = 5.5      ;//Minimum opening adjustment
   sinput  double            trade_MAX_buy_buysellratio  = 8.0      ;//Maximum opening adjustment
   input   double            trigger_sell_buysellratio   = -5.5     ;//Level to open BSR short
   sinput  double            trade_MIN_sell_buysellratio = -5.5     ;//Minimum opening adjustment
   sinput  double            trade_MAX_sell_buysellratio = -8.0     ;//Maximum opening adjustment  
//===========================================================================================================
   input   string            t_triggerSTR2               = "TRIGGER MANAGEMENT";//STR 2 =====================
   bool                      trigger_use_relstrength     = true     ;//Use Relative Strength filtro (Base)
   input   double            trigger_buy_relstrength     = 5.0      ;//Strength to open long
   sinput  double            trade_MIN_buy_relstrength   = 5.0      ;//Minimum opening adjustment
   sinput  double            trade_MAX_buy_relstrength   = 10.0      ;//Maximum opening adjustment
   input   double            trigger_sell_relstrength    = -5.0     ;//Strength to open short
   sinput  double            trade_MIN_sell_relstrength  = -5.0     ;//Minimum opening adjustment
   sinput  double            trade_MAX_sell_relstrength  = -10.0     ;//Maximum opening adjustment
//===========================================================================================================
   input   string            t_triggerGAP2               = "TRIGGER MANAGEMENT";//GAP 2 =====================   
   bool                      trigger_use_gap             = true     ;//Use Gap filtro
//   input   ENUM_TIMEFRAMES   periodGAP                   = 1     ;//TimeFrame Periodo GAP   
   input   double            trigger_gap_buy             = 7.0      ;//Level to open GAP long 
   sinput  double            trade_MIN_gap_buy           = 7.0      ;//Minimum opening adjustment
   sinput  double            trade_MAX_gap_buy           = 15.0      ;//Maximum opening adjustment
   input   double            trigger_gap_sell            = -7.0     ;//Level to open GAP short 
   sinput  double            trade_MIN_gap_sell          = -7.0     ;//Minimum opening adjustment
   sinput  double            trade_MAX_gap_sell          = -15.0     ;//Maximum opening adjustment   
//===========================================================================================================
   input   string            t_triggerUSD2               = "TRIGGER MANAGEMENT";//USD 2 =====================   
   bool                      trigger_use_Strength        = true     ;//Use Strength filtering
   input   ENUM_TIMEFRAMES   trigger_TF_Strength         = PERIOD_D1;//TimeFrame for USD Calculation
   input   double            trade_MIN_Strength          = 60       ;//Minimum % USD to open position
//===========================================================================================================
   sinput   string           t_triggerHM                = "TRIGGER MANAGEMENT";//MAPA DE CALOR =============
   bool                      trigger_UseHeatMap1         = false    ;//======================== 
   input   ENUM_TIMEFRAMES   trigger_TF_HM1              = 1440       ;//TimeFrame Heat Map 1 
   input   double            trade_MIN_HeatMap1          = 0.01     ;//Minimum % HeatMap1 to open position
//===========================================================================================================
   bool                      trigger_UseHeatMap2         = false    ;//======================== 
   input   ENUM_TIMEFRAMES   trigger_TF_HM2              = 240       ;//TimeFrame Heat Map 2
   input   double            trade_MIN_HeatMap2          = 0.01     ;//Minimum % HeatMap2 to open position
//===========================================================================================================
   bool                      trigger_UseHeatMap3         = false    ;//======================== 
   input   ENUM_TIMEFRAMES   trigger_TF_HM3              = 60       ;//TimeFrame Heat Map 3
   input   double            trade_MIN_HeatMap3          = 0.01     ;//Minimum % HeatMap3 to open position
//===========================================================================================================
   bool                      trigger_UseHeatMap4         = false    ;//========================
   input   ENUM_TIMEFRAMES   trigger_TF_HM4              = 30      ;//TimeFrame Heat Map 4
   input   double            trade_MIN_HeatMap4          = 0.01     ;//Minimum % HeatMap4 to open position
//===========================================================================================================
   bool                      trigger_UseHeatMap5         = false    ;//========================
   input   ENUM_TIMEFRAMES   trigger_TF_HM5              = 15     ;//TimeFrame Heat Map 5
   input   double            trade_MIN_HeatMap5          = 0.01     ;//Minimum % HeatMap5 to open position
//===========================================================================================================
   /*input*/   string            t_triggerMM                 = "TRIGGER MANAGEMENT";//MEDIAS MOVEIS =============
   bool                      trigger_Moving_Average1     = false     ;//======================== 
   /*input*/   int               trade_Period_Moving_Average1= 30       ;//Periodo Média Movel 1
   /*input*/   ENUM_TIMEFRAMES TF1                           = PERIOD_M5;//Moving Average Timeframe
   bool                      trigger_Moving_Average2     = false     ;//========================
   /*input*/   int               trade_Period_Moving_Average2= 30       ;//Período Média Móvel 2
   /*input*/   ENUM_TIMEFRAMES TF2                           = PERIOD_M15;//Moving Average Timeframe
   bool                      trigger_Moving_Average3     = false     ;//======================== 
   /*input*/   int               trade_Period_Moving_Average3= 30       ;//Periodo Média Movel 3
   /*input*/   ENUM_TIMEFRAMES TF3                           = PERIOD_M30;//Moving Average Timeframe
   bool                      trigger_Moving_Average4     = false     ;//======================== 
   /*input*/   int               trade_Period_Moving_Average4= 45       ;//Período Média Móvel 4
   /*input*/   ENUM_TIMEFRAMES TF4                           = PERIOD_M5;//Moving Average Timeframe
   bool                      trigger_Moving_Average5     = false     ;//======================== 
   /*input*/   int               trade_Period_Moving_Average5= 45       ;//Período Média Móvel 5
   /*input*/   ENUM_TIMEFRAMES TF5                           = PERIOD_M15;//Moving Average Timeframe
   bool                      trigger_Moving_Average6     = false     ;//======================== 
   /*input*/   int               trade_Period_Moving_Average6= 45       ;//Periodo Média Movel 6
   /*input*/   ENUM_TIMEFRAMES TF6                           = PERIOD_M30;//Moving Average Timeframe
   bool                      trigger_Moving_Average7     = false     ;//======================== 
   /*input*/   int               trade_Period_Moving_Average7= 60       ;//Período Média Móvel 7
   /*input*/   ENUM_TIMEFRAMES TF7                           = PERIOD_M5;//Moving Average Timeframe 
   bool                      trigger_Moving_Average8     = false     ;//======================== 
   /*input*/   int               trade_Period_Moving_Average8= 60       ;//Periodo Média Movel 8
   /*input*/   ENUM_TIMEFRAMES TF8                           = PERIOD_M15;//Moving Average Timeframe 
   bool                      trigger_Moving_Average9     = false     ;//======================== 
   /*input*/   int               trade_Period_Moving_Average9= 60       ;//Período Média Móvel 9
   /*input*/   ENUM_TIMEFRAMES TF9                           = PERIOD_M30;//Moving Average Timeframe
   bool                      trigger_Moving_Average10    = false     ;//======================== 
   /*input*/   int              trade_Period_Moving_Average10= 75       ;//Período Média Móvel 12
   /*input*/   ENUM_TIMEFRAMES TF10                          = PERIOD_M5;//Moving Average Timeframe 
   bool                      trigger_Moving_Average11    = false     ;//======================== 
   /*input*/   int              trade_Period_Moving_Average11= 75       ;//Periodo Média Movel 11
   /*input*/   ENUM_TIMEFRAMES TF11                          = PERIOD_M15;//Moving Average Timeframe 
   bool                      trigger_Moving_Average12    = false     ;//======================== 
   /*input*/   int              trade_Period_Moving_Average12= 75       ;//Período Média Móvel 12
   /*input*/   ENUM_TIMEFRAMES TF12                          = PERIOD_M30;//Moving Average Timeframe 
   bool                      trigger_Moving_Average13    = false     ;//======================== 
   /*input*/   int              trade_Period_Moving_Average13= 90       ;//Periodo Média Movel 13
   /*input*/   ENUM_TIMEFRAMES TF13                          = PERIOD_M5;//Moving Average Timeframe 
   bool                      trigger_Moving_Average14    = false     ;//======================== 
   /*input*/   int              trade_Period_Moving_Average14= 90       ;//Período Média Móvel 14
   /*input*/   ENUM_TIMEFRAMES TF14                          = PERIOD_M15;//Moving Average Timeframe 
   bool                      trigger_Moving_Average15    = false     ;//======================== 
   /*input*/   int              trade_Period_Moving_Average15= 90       ;//Período Média Móvel 15
   /*input*/   ENUM_TIMEFRAMES TF15                          = PERIOD_M30;//Moving Average Timeframe
//===========================================================================================================
   string                    t_triggerCANDLEDIR2         = "TRIGGER MANAGEMENT";//CANDLE DIRECTION ==
   bool                      trigger_Candle_Direction    = true     ;//Use a direção da vela
//===========================================================================================================
   bool                      UseCCI                      = false    ;//Use CCI to select
//===========================================================================================================
   bool                      UseBb                       = false    ;//Use BB
   double                    trigger_upperBand           = 1        ;//Nivel para abrir compra
   double                    trigger_lowerBand           = -1       ;//Nivel para abrir venda 
//===========================================================================================================
     string            t_trigger4                  = "TRIGGER MANAGEMENT";//CCI =======================
   bool                      UseCCI1                     = false    ;//Use CCI
      ENUM_TIMEFRAMES   periodCCI1                  = PERIOD_M30;//
      int               trade_Period_CCI1           = 20       ;//CCI Periodo
      double            trigger_CCI_CloseBuy1_21    = -100     ;//Nível de Compra CCI
      double            trigger_CCI_CloseSell1_21   = 100      ;//Nível de Venda CCI
   bool                      UseCCI2                     = false    ;//Use CCI
      ENUM_TIMEFRAMES   periodCCI2                  = PERIOD_H4;//
      int               trade_Period_CCI2           = 20       ;//CCI Periodo
      double            trigger_CCI_CloseBuy1_22    = -100     ;//Nível de Compra CCI
      double            trigger_CCI_CloseSell1_22   = 100      ;//Nível de Venda CCI
   bool                      UseCCI3                     = false    ;//Use CCI
      ENUM_TIMEFRAMES   periodCCI3                  = PERIOD_D1;//
      int               trade_Period_CCI3           = 20       ;//CCI Periodo
      double            trigger_CCI_CloseBuy1_23    = -100     ;//Nível de Compra CCI
      double            trigger_CCI_CloseSell1_23   = 100      ;//Nível de Venda CCI 
//===========================================================================================================
   input     string            t_trigger5                  = "TRIGGER MANAGEMENT";//RSI =======================
   bool                      UseRSI1                     = false    ;//Use RSI 
      ENUM_TIMEFRAMES   periodRSI1                  = PERIOD_M30;//
      int               trade_Period_RSI1           = 20       ;//RSI Periodo 
   bool                      UseRSI2                     = false    ;//Use RSI
      ENUM_TIMEFRAMES   periodRSI2                  = PERIOD_H4;//
      int               trade_Period_RSI2           = 20       ;//RSI Periodo 
   bool                      UseRSI3                     = false    ;//Use RSI
      ENUM_TIMEFRAMES   periodRSI3                  = PERIOD_D1;//
      int               trade_Period_RSI3           = 20       ;//RSI Periodo
//===========================================================================================================
     string            t_trigger55                  = "TRIGGER MANAGEMENT";//RSI =======================
sinput   bool                    trigger_use_RSI            = true;              // Use RSI filtering
sinput   double                  trigger_buy_RSI            = 75;                // RSI level to open Buy
sinput   double                  trigger_sell_RSI           =25;                 // RSI level to open Sell
sinput   int                     trigger_RSI_period         =2;                  // RSI Period
sinput   ENUM_TIMEFRAMES         trigger_RSI_Timeframe      = 1440;                // RSI Timeframe
sinput   ENUM_APPLIED_PRICE      trigger_RSI_Applied        =0;                  // RSI Applied Price
sinput   int                     trigger_RSI_shift          =0;                  // RSI 0=current bar 1=previous bar
//===========================================================================================================
     string            t_trigger6                  = "TRIGGER MANAGEMENT";//MACD ====================== 
   bool                      trigger_MACD1               = false    ;//Use MACD
      ENUM_TIMEFRAMES   periodMACD1                 = PERIOD_M30;//
      int               FastPeriod                  = 9        ;//Fast EMA Period
      int               SlowPeriod                  = 12       ;//Slow EMA Period
      int               SignPeriod                  = 26       ;//Signal SMA Period
                        ENUM_APPLIED_PRICE Price    = PRICE_WEIGHTED;//MACD price
   int                       BarToTest                   = 0        ;//Bar to test
//--- indicator buffers
   double                    ExtMacdBuffer[];
   double                    ExtSignalBuffer[];
//--- right input parameters flag
   bool                      ExtParameters               = false    ;//=======================
//===========================================================================================================
   bool                      trigger_MACD2               = false    ;//Use MACD =============================
      ENUM_TIMEFRAMES   periodMACD2                 = PERIOD_H4;//
      int               FastPeriod1                 = 9        ;//Fast EMA Period
      int               SlowPeriod1                 = 12       ;//Slow EMA Period
      int               SignPeriod1                 = 26       ;//Signal SMA Period
                        ENUM_APPLIED_PRICE Price1   = PRICE_WEIGHTED;//MACD price
   int                       BarToTest1                  = 0        ;//Bar to test
//--- indicator buffers
   double                    ExtMacdBuffer1[];
   double                    ExtSignalBuffer1[];
//--- right input parameters flag
   bool                      ExtParameters1              = false    ;//=======================
//===========================================================================================================
   bool                      trigger_MACD3               = false    ;//Use MACD =============================
      ENUM_TIMEFRAMES   periodMACD3                 = PERIOD_D1;//
      int               FastPeriod2                 = 9        ;//Fast EMA Period
      int               SlowPeriod2                 = 12       ;//Slow EMA Period
      int               SignPeriod2                 = 26       ;//Signal SMA Period
                        ENUM_APPLIED_PRICE Price2   = PRICE_WEIGHTED;//MACD price
   int                       BarToTest2                  = 0        ;//Bar to test
//--- indicator buffers
   double                    ExtMacdBuffer2[];
   double                    ExtSignalBuffer2[];
//--- right input parameters flag
   bool                      ExtParameters2              = false    ;//=======================
//===========================================================================================================
   string                    t_basket                    = "BASKET MANAGEMENT"; //LOTES/STOPLOOS/TAKE PROFIT
//sinput double              lot                         = 0.10      ;//Lote
//---
   double                    lot                         = 0.01      ;//Fixed lot size 0.00
   double                    lotStep                     = 0.01      ;//Lot size (0.01)
//---
   int                       MaxTrades                   = 1         ;//Maximo de trades por par
   int                       MaxTotalTrades              = 28        ;//Max total trades geral
   double                    MaxSpread                   = 5.0       ;//Max Spread Allowe
   int                       Basket_Target               = 0         ;//Basket Take Profit in $
   int                       Basket_StopLoss             = 0         ;//Basket Stop Lloss in $
   int                       Piptp                       = 20        ;//Takeprofit em pips 
   double                    PiptpStep                   = 5         ;
   int                       Pipsl                       = 0        ;//Take 20 - Stoploss em pips 
   double                    PipslStep                   = 5         ;
   bool                      TrailLastLock               = true      ;//Trilhar o último bloqueio definido
   double                    TrailDistance               = 1.0       ;//A distância da trilha 0 significa o último bloqueio
   int                       StopProfit                  = 0         ;//Pare depois de tantas cestas lucrativas
   double                    Adr1tp                      = 0         ;//Takeprofit percent adr(10) 0=None
// double                      Adr1tpStep                = 100;
   double                    Adr1sl                      = 0         ;//Stoploss adr percent adr(10) 0 = None
// double                      Adr1slStep                = 100;
   int                       StopLoss                    = 0         ;//Pare depois de tantas cestas perdidas
   bool                      OnlyAddProfit               = false     ;//Apenas adiciona negócios no lucro
   bool                      CloseAllSession             = false     ;//Feche todas as negociações após a(s) sessão(ões)
//===========================================================================================================
   string                    t_time                      = "TIME MANAGEMENT";//SESSÕES
   bool                      UseSession1                 = true      ;//AUD
   string                    sess1start                  = "12:01"   ;//Inicio 12:01
   string                    sess1end                    = "15:59"   ;//Fim 15:59
   string                    sess1comment                = "HFT Illusion -AUD";//AUD
//=========================================================================================================== 
   bool                      UseSession2                 = true      ;//NZD
   string                    sess2start                  = "16:01"   ;//Inicio 16:01
   string                    sess2end                    = "19:59"   ;//Fim 19:59
   string                    sess2comment                = "HFT Illusion -NZD";//NZD
//===========================================================================================================
   bool                      UseSession3                 = true      ;//JPY
   string                    sess3start                  = "20:01"   ;//Inicio 20:01
   string                    sess3end                    = "23:59"   ;//Fim 23:59 / 00:59
   string                    sess3comment                = "HFT Illusion -JPY";//JPY
//===========================================================================================================
   bool                      UseSession4                 = true      ;//CHF
   string                    sess4start                  = "00:01"   ;//Inicio 00:01
   string                    sess4end                    = "03:59"   ;//Fim 03:59
   string                    sess4comment                = "HFT Illusion -CHF";//CHF
//===========================================================================================================
   bool                      UseSession5                 = true      ;//EUR/GBP
   string                    sess5start                  = "04:01"   ;//Inicio 04:01
   string                    sess5end                    = "07:59"   ;//Fim 07:59
   string                    sess5comment                = "HFT Illusion -EUR/GBP";//EUR/GBP
//===========================================================================================================
   bool                      UseSession6                 = true      ;//USD/CAD
   string                    sess6start                  = "08:01"   ;//Inicio 08:01
   string                    sess6end                    = "11:59"   ;//Fim 11:59
   string                    sess6comment                = "HFT Illusion -USD/CAD";//USD/CAD 
//===========================================================================================================
   input   string            t_chart                     = "CHART MANAGEMENT";//Chart
   input   ENUM_TIMEFRAMES   TimeFrame                   = 30        ;//TimeFrame, open Chart
   string                    usertemplate                = "FENIX" ;//SantosFX
   int                       x_axis                      = 0         ;//Ajustar para esquerda/direita
   int                       y_axis                      = -65       ;//Ajustar para cima/baixo
//===========================================================================================================   
   int                       a_axis                      = 540       ;//Esquerda X Direita
   int                       aa_axis                     = 51        ;//Cima X Baixo 
   int                       z_axis                      = 540       ;//Esquerda X Direita              
//===========================================================================================================MEDIAS MOVEIS/CANDLE.D
   int                       b_axis                      = 380       ;//Ajustar para esquerda/direita
   int                       bb_axis                     = -65       ;//Ajustar para cima/baixo
//===========================================================================================================PRICE
   int                       c_axis                      = 645         ;//Ajustar para esquerda/direita 20
   int                       cc_axis                     = -65       ;//Ajustar para cima/baixo
//===========================================================================================================RATIO 
   int                       d_axis                      = 0         ;//Ajustar para esquerda/direita
   int                       dd_axis                     = -65       ;//Ajustar para cima/baixo
//===========================================================================================================
   int BeforeMin = 43200;
   int FontSize = 8;
   string FontName = "Arial";
   int ShiftX = 0;
   int ShiftY = 0;
   int Corner = 0;
//===========================================================================================================
//LOTE PAINEL
string button_increase_lot = "INCREASE LOT";
string button_decrease_lot = "DECREASE LOT";
//---
string button_increase_Piptp = "INCREASE STOPTP";
string button_decrease_Piptp = "DECREASE STOPTP";
string button_increase_Pipsl = "INCREASE STOPSL";
string button_decrease_Pipsl = "DECREASE STOPSL";

string button_enable_basket_lock="ENABLE BASKET LOCK";
string button_enable_basket_tp = "ENABLE BASKET TP";
string button_enable_basket_sl = "ENABLE BASKET SL";
//---
string button_increase_Adr1tp = "INCREASE ADRSTOPTP";
string button_decrease_Adr1tp = "DECREASE ADRSTOPTP";
string button_increase_Adr1sl = "INCREASE ADRSTOPSL";
string button_decrease_Adr1sl = "DECREASE ADRSTOPSL";


//LOTE PAINEL
//PAINEL LOTES
//buttons for Single and Basket trade inputs
string button_SB1 = "btn_SB_lot_input1";
string button_SB2 = "btn_SB_lot_input2";
string button_SB3 = "btn_SB_lot_input3";
string button_SB4 = "btn_SB_lot_input4";
string button_SB5 = "btn_SB_lot_input5";
string button_SB6 = "btn_SB_lot_input6";
string button_SB7 = "btn_SB_lot_input7";
string button_SB8 = "btn_SB_lot_input8";
string button_SB9 = "btn_SB_TP_input9";
string button_SB10 = "btn_SB_TP_input10";
string button_SB11 = "btn_SB_TP_input11";
string button_SB12 = "btn_SB_TP_input12";

//buttons for HARE trade inputs
string button_H1 = "btn_H_lot_input1";
string button_H2 = "btn_H_lot_input2";
string button_H3 = "btn_H_lot_input3";
string button_H4 = "btn_H_lot_input4";
string button_H5 = "btn_H_lot_input5";
string button_H6 = "btn_H_lot_input6";
string button_H7 = "btn_H_lot_input7";
string button_H8 = "btn_H_lot_input8";
string button_H9 = "btn_H_TP_input9";
string button_H10 = "btn_H_TP_input10";
string button_H11 = "btn_H_TP_input11";
string button_H12 = "btn_H_TP_input12";

//buttons for TORTOISE trade inputs
string button_T1 = "btn_T_lot_input1";
string button_T2 = "btn_T_lot_input2";
string button_T3 = "btn_T_lot_input3";
string button_T4 = "btn_T_lot_input4";
string button_T5 = "btn_T_lot_input5";
string button_T6 = "btn_T_lot_input6";
string button_T7 = "btn_T_lot_input7";
string button_T8 = "btn_T_lot_input8";
string button_T9 = "btn_T_TP_input9";
string button_T10 = "btn_T_TP_input10";
string button_T11 = "btn_T_TP_input11";
string button_T12 = "btn_T_TP_input12";

int S_BS_TP=0.0,S_BS_SL=0.0,H_TP=0.0,H_SL=0.0,TOR_TP=0.0,TOR_SL=0.0;
double S_BS_Lot=0.01,H_Lot=0.01,TOR_Lot=0.01;
string temp_lot="";
string temp_lotc="";
//PAINEL LOTES
string button_close_basket_All = "btn_Close ALL"; 
string button_close_basket_Prof = "btn_Close Prof";
string button_close_basket_Loss = "btn_Close Loss";

string button_reset_ea = "RESET EA";

struct   Pair  
  {
  double Bb;
  string symbol;
  string symbol00;
  string symbol11;
  string symbol22;
  string symbol33;
  string symbol44;
  string symbol55;
  string symbol66;
  string symbol3;
  double pairpip;
  double pips;
  double pips00;
  double pips11;
  double pips22;
  double pips33;
  double pips44;
  double pips55;
  double pips66;
  double spread;
  double spread00;
  double spread11;
  double spread22;
  double spread33;
  double spread44;
  double spread55;
  double spread66;
  double hi;
  double hi00;
  double hi11;
  double hi22;
  double hi33;
  double hi44;
  double hi55;
  double hi66;
  double high3;
  double lo;
  double lo00;
  double lo11;
  double lo22;
  double lo33;
  double lo44;
  double lo55;
  double lo66;
  double low3;
  double open;
  double open00;
  double open11;
  double open22;
  double open33;
  double open44;
  double open55;
  double open66;
  double open3;
  double close;
  double close00;
  double close11;
  double close22;
  double close33;
  double close44;
  double close55;
  double close66;
  double close3;
  double point;
  double point00;
  double point11;
  double point22;
  double point33;
  double point44;
  double point55;
  double point66;
  double point3;
  double lots;
  double ask;
  double ask00;
  double ask11;
  double ask22;
  double ask33;
  double ask44;
  double ask55;
  double ask66;
  double ask3;
  double bid;
  double bid00;
  double bid11;
  double bid22;
  double bid33;
  double bid44;
  double bid55;
  double bid66;
  double bid3;
  double range;
  double range00;
  double range11;
  double range22;
  double range33;
  double range44;
  double range55;
  double range66;
  double range3;
  double ratio;
  double ratio00;
  double ratio11;
  double ratio22;
  double ratio33;
  double ratio44;
  double ratio55;
  double ratio66;
  double ratio3;
  double calc;
  double calc00;
  double calc11;
  double calc22;
  double calc33;
  double calc44;
  double calc55;
  double calc66;
  int    pipsfactor;
  int    pipsfactor00;
  int    pipsfactor11;
  int    pipsfactor22;
  int    pipsfactor33;
  int    pipsfactor44;
  int    pipsfactor55;
  int    pipsfactor66;  
  };
  
string DefaultPairs[] = {"AUDCAD","AUDCHF","AUDJPY","AUDNZD","AUDUSD","CADCHF","CADJPY","CHFJPY","EURAUD","EURCAD","EURCHF","EURGBP","EURJPY","EURNZD","EURUSD","GBPAUD","GBPCAD","GBPCHF","GBPJPY","GBPNZD","GBPUSD","NZDCAD","NZDCHF","NZDJPY","NZDUSD","USDCAD","USDCHF","USDJPY"};
string TradePairs[];
string curr[8] = {"USD","EUR","GBP","JPY","AUD","NZD","CAD","CHF"}; 
string postfix=StringSubstr(Symbol(),6,6);//6,10
string tempsym = "";
string EUR[7] = {"EURAUD","EURCAD","EURCHF","EURGBP","EURJPY","EURNZD","EURUSD"};
string GBP[6] = {"GBPAUD","GBPCAD","GBPCHF","GBPJPY","GBPNZD","GBPUSD"};
string GBP_R[1] = {"EURGBP"};
string CHF[1] = {"CHFJPY"};
string CHF_R[6] = {"AUDCHF","CADCHF","EURCHF","GBPCHF","NZDCHF","USDCHF"};
string USD[3] = {"USDCAD","USDCHF","USDJPY"};
string USD_R[4] = {"AUDUSD","EURUSD","GBPUSD","NZDUSD"};
string CAD[2] = {"CADCHF","CADJPY"};
string CAD_R[5] = {"AUDCAD","EURCAD","GBPCAD","NZDCAD","USDCAD"};
string NZD[4] = {"NZDCAD","NZDCHF","NZDJPY","NZDUSD"};
string NZD_R[3] = {"AUDNZD","EURNZD","GBPNZD"};
string AUD[5] = {"AUDCAD","AUDCHF","AUDJPY","AUDNZD","AUDUSD"};
string AUD_R[2] = {"EURAUD","GBPAUD"};
string JPY_R[7] = {"AUDJPY","CADJPY","CHFJPY","EURJPY","GBPJPY","NZDJPY","USDJPY"};

string   _font="Consolas";

string TMz;
datetime LastAlertTime;
long           thisChart;
int            timeOffset;
datetime       ServerLocalOffset;
datetime       localtime;
int Broker_Time_Offset = 3;
int Alert_Mod = 1; // Select Alert Mode 


struct pairinf 
  {
  double PairPip;
  int    pipsfactor;
  int    pipsfactor00;
  int    pipsfactor11;
  int    pipsfactor22;
  int    pipsfactor33;
  int    pipsfactor44;
  int    pipsfactor55;
  int    pipsfactor66;
  double Pips;
  double pips00;
  double pips11;
  double pips22;
  double pips33;
  double pips44;
  double pips55;
  double pips66;
  double PipsSig;
  double Pipsprev;
  double Spread;
  double Spread00;
  double Spread11;
  double Spread22;
  double Spread33;
  double Spread44;
  double Spread55;
  double Spread66;
  double point;
  double point00;
  double point11;
  double point22;
  double point33;
  double point44;
  double point55;
  double point66;
  double point3;
  int    lastSignal;
  int    base;
  int    quote;
  int    Bb;
  bool   dux; 
  }; 
pairinf  pairinfo[];
struct LBSRat{
 double LBSr;
}; LBSRat LBSRatio[];

#define  NONE 0
#define  DOWN -1
#define  UP 1
/*sinput*/ string masterPreamble = "CM_GVC_TF_10_";
#define  NOTHING 0
#define  BUY 1
#define  SELL 2

struct   signal 
  {
  double upperBand;
  double lowerBand; 
  string symbol;
  string symbol00;  string symbol11;  string symbol22;  string symbol33;  string symbol44;  string symbol55;  string symbol66;
  string symbol3;
  string digit3;
  double range;
  double range00;  double range11;  double range22;  double range33;  double range44;  double range55;  double range66;
  double range3;
  double ratio;
  double ratio00;  double ratio11;  double ratio22;  double ratio33;  double ratio44;  double ratio55;  double ratio66;
  double ratio3;
  double bidratio;
  double bidratio00;  double bidratio11;  double bidratio22;  double bidratio33;  double bidratio44;  double bidratio55;  double bidratio66;
  double pips00;  double pips11;  double pips22;  double pips33;  double pips44;  double pips55;  double pips66;
  double bidratio3;
  double fact;
  double fact00;  double fact11;  double fact22;  double fact33;  double fact44;  double fact55;  double fact66; 
  double strength;
  double strength00;  double strength11;  double strength22;  double strength33;  double strength44;  double strength55;  double strength66;  
  double strength_old;
  double strength_old00;  double strength_old11;  double strength_old22;  double strength_old33;  double strength_old44;  double strength_old55;  double strength_old66;    
  double strength1;
  double strength100;  double strength111;  double strength122;  double strength133;  double strength144;  double strength155;  double strength166;
  double strength2;
  double strength200;  double strength211;  double strength222;  double strength233;  double strength244;  double strength255;  double strength266;
  double calc;
  double calc00;  double calc11;  double calc22;  double calc33;  double calc44;  double calc55;  double calc66;
  double strength3;
  double strength300;  double strength311;  double strength322;  double strength333;  double strength344;  double strength355;  double strength366;
  double strength4;
  double strength400;  double strength411;  double strength422;  double strength433;  double strength444;  double strength455;  double strength466;
  double strength5;
  double strength500;  double strength511;  double strength522;  double strength533;  double strength544;  double strength555;  double strength566;
  double strength6;
  double strength600;  double strength611;  double strength622;  double strength633;  double strength644;  double strength655;  double strength666;
  double strength7;
  double strength700;  double strength711;  double strength722;  double strength733;  double strength744;  double strength755;  double strength766;
  double strength8;
  double strength800;  double strength811;  double strength822;  double strength833;  double strength844;  double strength855;  double strength866;
  double strength_Gap;
  double strength_Gap00;  double strength_Gap11;  double strength_Gap22;  double strength_Gap33;  double strength_Gap44;  double strength_Gap55;  double strength_Gap66;
  double hi;
  double hi00;  double hi11;  double hi22;  double hi33;  double hi44;  double hi55;  double hi66;
  double lo;
  double lo00;  double lo11;  double lo22;  double lo33;  double lo44;  double lo55;  double lo66;
  double high3;
  double low3;
  double prevratio; 
  double prevratio00;  double prevratio11;  double prevratio22;  double prevratio33;  double prevratio44;  double prevratio55;  double prevratio66;  
  double prevbid;
  double prevbid00;  double prevbid11;  double prevbid22;  double prevbid33;  double prevbid44;  double prevbid55;  double prevbid66;   
  int    shift;
  int    shift00;  int    shift11;  int    shift22;  int    shift33;  int    shift44;  int    shift55;  int    shift66;
  double open;
  double open00;  double open11;  double open22;  double open33;  double open44;  double open55;  double open66;
  double close;
  double close00;  double close11;  double close22;  double close33;  double close44;  double close55;  double close66;
  double open3;
  double close3;
  double bid;
  double bid00;  double bid11;  double bid22;  double bid33;  double bid44;  double bid55;  double bid66;
  double bid3;
  double ask3;
  double point;
  double point00;  double point11;  double point22;  double point33;  double point44;  double point55;  double point66;
  double point3;    
  double Signalperc;
  double Signalperc1;
  double Signalperc2;
  double Signalperc3;
  double Signalperc4;    
  double SigRatio;
  double SigRatio00;  double SigRatio11;  double SigRatio22;  double SigRatio33;  double SigRatio44;  double SigRatio55;  double SigRatio66;
  double SigRelStr;
  double SigRelStr00;  double SigRelStr11;  double SigRelStr22;  double SigRelStr33;  double SigRelStr44;  double SigRelStr55;  double SigRelStr66;
  double SigBSRatio;
  double SigBSRatio00;  double SigBSRatio11;  double SigBSRatio22;  double SigBSRatio33;  double SigBSRatio44;  double SigBSRatio55;  double SigBSRatio66;    
  double SigCRS;
  double SigGap;
  double SigGap00;  double SigGap11;  double SigGap22;  double SigGap33;  double SigGap44;  double SigGap55;  double SigGap66;
  double SigGapPrev;
  double SigGapPrev00;  double SigGapPrev11;  double SigGapPrev22;  double SigGapPrev33;  double SigGapPrev44;  double SigGapPrev55;  double SigGapPrev66;
  double SigRatioPrev;
  double SigRatioPrev00;  double SigRatioPrev11;  double SigRatioPrev22;  double SigRatioPrev33;  double SigRatioPrev44;  double SigRatioPrev55;  double SigRatioPrev66;
  //MEDIAS MOVEIS UP/DOW  
  double SignalM01up;
  double SignalM01dn;
  double SignalM02up;
  double SignalM02dn;
  double SignalM03up;
  double SignalM03dn;
  double SignalM04up;
  double SignalM04dn;
  double SignalM05up;
  double SignalM05dn;
  double SignalM06up;
  double SignalM06dn;
  double SignalM07up;
  double SignalM07dn;
  double SignalM08up;
  double SignalM08dn;
  double SignalM09up;
  double SignalM09dn;
  double SignalM10up;
  double SignalM10dn;
  double SignalM11up;
  double SignalM11dn;
  double SignalM12up;
  double SignalM12dn;
  double SignalM13up;
  double SignalM13dn;
  double SignalM14up;
  double SignalM14dn;
  double SignalM15up;
  double SignalM15dn;
  double SignalM16up;
  double SignalM16dn;
  double SignalM17up;
  double SignalM17dn;
  double SignalM18up;
  double SignalM18dn;
  double SignalM19up;
  double SignalM19dn;
  double SignalM20up;
  double SignalM20dn;
  double SignalM21up;
  double SignalM21dn;
  double SignalM22up;
  double SignalM22dn;
  double SignalM23up;
  double SignalM23dn;
  double SignalM24up;
  double SignalM24dn;
  double SignalM25up;
  double SignalM25dn;
  double SignalM26up;
  double SignalM26dn;
  double SignalM27up;
  double SignalM27dn;
  double SignalM28up;
  double SignalM28dn;
  double SignalM29up;
  double SignalM29dn;
  double SignalM30up;
  double SignalM30dn;
//--MM
  double Signalmaup1;
  double Signalmadn1;
  double Signalmaup2;
  double Signalmadn2;
  double Signalmaup3;
  double Signalmadn3;
  double Signalmaup4;
  double Signalmadn4;
  double Signalmaup5;
  double Signalmadn5;
  double Signalmaup6;
  double Signalmadn6;
  double Signalmaup7;
  double Signalmadn7;
  double Signalmaup8;
  double Signalmadn8;
  double Signalmaup9;
  double Signalmadn9;
  double Signalmaup10;
  double Signalmadn10;
  double Signalmaup11;
  double Signalmadn11;
  double Signalmaup12;
  double Signalmadn12;
  double Signalmaup13;
  double Signalmadn13;
  double Signalmaup14;
  double Signalmadn14;
  double Signalmaup15;
  double Signalmadn15;
//--MM 
  double prevSignalusd;
  double Signalusd;
  //CANDLE DIRECTION
  double SignalCDm1;
  double SignalCDm5;
  double SignalCDm15;
  double SignalCDm30;
  double SignalCDh1;
  double SignalCDh4;
  double SignalCDd1;
  double SignalCDw1;
  double SignalCDmn;
  double Signaldirup;
  double Signaldirdn;
  //CCI
  double Signalcci;
  double Signalcci1;
  double Signalcci2;
  double Signalcci3;
  double Signalcciup1;
  double Signalccidn1;
  double Signalcciup2;
  double Signalccidn2;
  double Signalcciup3;
  double Signalccidn3;
  //RSI
  double highRatio;
  double lowRatio;
  double RSI;
  double SigRSI;
  double Signalrsi;
  double xLBSr;   
  //double Signalrsi;
  double Signalrsi1;
  double Signalrsi2;
  double Signalrsi3;
  double Signalrsiup1;
  double Signalrsidn1;
  double Signalrsiup2;
  double Signalrsidn2;
  double Signalrsiup3;
  double Signalrsidn3;
  //MACD
  double SignalMACDup01;
  double SignalMACDdn01;
  double SignalMACDup02;
  double SignalMACDdn02;
  double SignalMACDup03;
  double SignalMACDdn03;
  //HI-LO ASK BID
  double high1;
  double low1;
  double ask1;
  double range2;
  //double bid;
  int    digit1;
  //HI-LO ASK BID 
  //SIGNAL USD
  //double Signalusd;
  //double Signaldirup;
  //double Signaldirdn;
  //double prevSignalusd;
  double Signalm1;
  double Signalm5;
  double Signalm15;
  double Signalm30;
  double Signalh1;
  double Signalh4;
  double Signald1;
  double Signalw1;
  double Signalmn;
//  double buystrength;//
//  double sellstrength;//
  //SIGNAL USD
  //INTRADAY
//  double Signalm1;
//  double Signalm5;
//  double Signalm15;
//  double Signalm30;
//  double Signalh1;
//  double Signalh4;
//  double Signald1;
//  double Signalw1;
//  double Signalmn;
//  double Signalusd;
  //INTRADAY       
  };
signal signals[];

struct currency 
  {
   string    curr;
   string    curr00;
   double    strength;
   double    strength00;  double    strength11;  double    strength22;  double    strength33;  double    strength44;  double    strength55;  double    strength66;
   double    prevstrength;
   double    prevstrength00;  double    prevstrength11;  double    prevstrength22;  double    prevstrength33;  double    prevstrength44;  double    prevstrength55;  double    prevstrength66;
   double    crs;
   int       sync;
   datetime  lastbar;
  }
; currency currencies[8];

double totalbuystrength,totalsellstrength;
double Pips[28],Spread[28],Signalm1[28],Signalm5[28],Signalm15[28],Signalm30[28],Signalh1[28],Signalh4[28],Signald1[28],Signalw1[28],Signalmn[28],Signalusd[28],upperBand[28],lowerBand[28];
color ProfitColor,ProfitColor1,ProfitColor2,ProfitColor3,PipsColor,LotColor,LotColor1,OrdColor,OrdColor1,Color,Color1,Color2,Color3,Color4,Color5,Color6,Color7,Color8,Color9,Color10,Color11,Color12;
color BackGrnCol =C'20,20,20';
color LineColor=clrBlack;
color TextColor=clrBlack;
double adr1[28],adr5[28],adr10[28],adr20[28],adr[28];

struct adrval 
  {
  double adr;
  double adr1;
  double adr5;
  double adr10;
  double adr20;
  }; 
adrval adrvalues[];

double totalprofit,totallots;

datetime s1start,s2start,s3start,s4start,s5start,s6start;
datetime s1end,s2end,s3end,s4end,s5end,s6end;

string comment;
int    strper = period_STR;
int    profitbaskets = 0;
int    lossbaskets = 0;
int    ticket,pipsfactor;
int    orders  = 0;
double PairPip;
double blots[28],slots[28],bprofit[28],sprofit[28],tprofit[28],bpos[28],spos[28],singolprofit[28];
double BuyMin[28],BuyMax[28],BuyMinLot[28],BuyMaxTic[28],BuyTicProfit[28],BuyProfit[28],ProfitBuy[28];
double SellMin[28],SellMax[28],SellMinLot[28],SellMaxTic[28],SellTicProfit[28],SellProfit[28],ProfitSell[28];
Pair list[];
Pair list00[];
Pair list11[];
Pair list22[];
Pair list33[];
Pair list44[];
Pair list55[];
Pair list66[];
bool   CloseAll;
string suffix="";//INTRADAY
//string      sep=","; 
//ushort  u_sep=StringGetCharacter(sep,0);
//string postfix=StringSubstr(Symbol(),6,10);
int   symb_cnt=0;
int   period1[]= {240,1440,10080,43200};
int   period[]= {5,15,60};
double factor;
int labelcolor,labelcolor1,labelcolor2=clrNONE,labelcolor3,labelcolor4,labelcolor5,labelcolor6,labelcolor7,labelcolor8,labelcolor9,labelcolor10,labelcolor11;
double GetBalanceSymbol,SymbolMaxDD,SymbolMaxHi;
double PercentFloatingSymbol=0;
double PercentMaxDDSymbol=0;
datetime newday=0;
datetime newm1=0; 
bool Accending=true;
/* HP */
int localday = 99;
bool s1active = false;
bool s2active = false;
bool s3active = false;
bool s4active = false;
bool s5active = false;
bool s6active = false;
MqlDateTime sess;
string strspl[];
double currentlock = 0.0;
bool   trailstarted = false;
double lockdistance = 0.0;
int    totaltrades = 0;
int    maxtotaltrades=0;
double stoploss;
double takeprofit;
double currstrength[8];
double currstrength00[8];  double currstrength11[8];  double currstrength22[8];  double currstrength33[8];  double currstrength44[8];  double currstrength55[8];  double currstrength66[8];
double prevstrength[8];
double prevstrength00[8];  double prevstrength11[8];  double prevstrength22[8];  double prevstrength33[8];  double prevstrength44[8];  double prevstrength55[8];  double prevstrength66[8];  
int Current;
//string Sig[28],Sell;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {  
  //--- indicator buffers mapping

  string s;
  string name;
    s = masterPreamble; //_symbolPair;
    //s = Symbol();
    for (int i = ObjectsTotal() - 1; i >= 0; i--)
    {
        name = ObjectName(i);
        if (StringSubstr(name, 0, StringLen(s)) == s)
        {
            ObjectDelete(name);
        }
    }                
  if (UseDefaultPairs == true)
  ArrayCopy(TradePairs,DefaultPairs);
  else
  StringSplit(OwnPairs,',',TradePairs);
   
  for (int i=0;i<8;i++)
  currencies[i].curr = curr[i]; 

  if (ArraySize(TradePairs) <= 0) 
  {
  Print("No pairs to trade");
  return(INIT_FAILED);
  }
   
  ArrayResize(adrvalues,ArraySize(TradePairs));
  ArrayResize(signals,ArraySize(TradePairs));
  ArrayResize(pairinfo,ArraySize(TradePairs));
  
  for(int i=0;i<ArraySize(TradePairs);i++){
  TradePairs[i]=TradePairs[i]+postfix; }
  ArrayResize(list,ArraySize(TradePairs));
  for(int i=0; i<ArraySize(list); i++){
  
  
  
  pairinfo[i].base = StringSubstr(TradePairs[i],0,3);
  pairinfo[i].quote = StringSubstr(TradePairs[i],3,0);
   
  if (MarketInfo(TradePairs[i] ,MODE_DIGITS) == 4 || MarketInfo(TradePairs[i] ,MODE_DIGITS) == 2)
  {
  pairinfo[i].PairPip = MarketInfo(TradePairs[i] ,MODE_POINT);
  pairinfo[i].pipsfactor = 1;
  } 
  else
  { 
  pairinfo[i].PairPip = MarketInfo(TradePairs[i] ,MODE_POINT)*10;
  pairinfo[i].pipsfactor = 10;
  }
 
  SetEditLabel("minprofit",x_axis+1207,y_axis+375,95,34,DoubleToString(Min_Profit,1),30,clrBlue,clrDimGray,"\n"); //  "goal",440,618,50,40,
  
                          
  //SetPanel("A3"+IntegerToString(i),0,x_axis+850,(i*12)+y_axis+234,10,12,clrBlack,C'61,61,61',1); 
  //SetPanel("ADR"+IntegerToString(i),0,x_axis+525,(i*12)+y_axis+234,10,12,clrBlack,C'61,61,61',1); 
    
  SetPanel("HM1"+IntegerToString(i),0,(i*47)+x_axis+12,y_axis+612,25,10,BackGrnCol,clrDimGray,1);
  SetPanel("HM2"+IntegerToString(i),0,(i*47)+x_axis+12,y_axis+624,25,10,BackGrnCol,clrDimGray,1);
  SetPanel("HM3"+IntegerToString(i),0,(i*47)+x_axis+12,y_axis+636,25,10,BackGrnCol,clrDimGray,1);
  SetPanel("HM4"+IntegerToString(i),0,(i*47)+x_axis+12,y_axis+648,25,10,BackGrnCol,clrDimGray,1);
  SetPanel("HM5"+IntegerToString(i),0,(i*47)+x_axis+12,y_axis+660,25,10,BackGrnCol,clrDimGray,1);  

  //SetPanel("TP110",0,x_axis+1000,y_axis+70,300,155,Black,Yellow,1);//CAIXA AMARELA BOTAO INDICADORES
  //SetPanel("TP150",0,x_axis+450,y_axis+233,210,340,Black,Yellow,1);//CAIXA AMARELA 02 PRICE
  //SetPanel("TP100",0,x_axis+880,y_axis+233,228,340,Black,Yellow,1);//CAIXA AMARELA MEIO
  //SetPanel("TP120",0,x_axis+1357,y_axis+233,189,340,Black,Yellow,1);//CAIXA AMARELA LOTES
  //SetPanel("TP130",0,x_axis+1109,y_axis+233,247,340,Black,Yellow,1);//CAIXA AMARELA LADO LOTES
  //SetPanel("TP140",0,x_axis+1168,y_axis+233,40,337,Black,Yellow,1);//CAIXA AMARELA LOTES STOP
  //Create_Button(IntegerToString(i)+"Pair",StringSubstr(TradePairs[i],0,6),47 ,10,(i*47)+c_axis-675 ,cc_axis+602,clrBlack,clrWhite);
  Create_Button(IntegerToString(i)+"Pair",StringSubstr(TradePairs[i],0,6),50 ,10,c_axis+165 ,(i*12)+cc_axis+234,clrBlack,clrWhite);
  Create_Button(i+"Hold","~",10 ,10,(i*47)+c_axis-642,cc_axis+648,C'35,35,35',clrAqua);
  Create_Button(i+"BUY","B",10 ,10,(i*47)+c_axis-642,cc_axis+612,C'35,35,35',clrLime);           
  Create_Button(i+"SELL","S",10 ,10,(i*47)+c_axis-642 ,cc_axis+624,C'35,35,35',clrRed);
  Create_Button(i+"CLOSE","C",10 ,10,(i*47)+c_axis-642,cc_axis+636,C'35,35,35',clrYellow);

  SetPanel("Report",0,x_axis+1207,y_axis+328,95,50,C'30,30,30',C'61,61,61',1);//CINZA HEDGE
  SetPanel("A01"+IntegerToString(i),0,c_axis+235,(i*12)+cc_axis+234,15,10,clrBlack,C'61,61,61',1);//SPREAD           
  SetText("Spr1"+IntegerToString(i),0,c_axis+235,(i*12)+cc_axis+234,Orange,6);//
  //SetPanel("A02"+IntegerToString(i),0,c_axis+250,(i*12)+cc_axis+234,20,10,clrBlack,C'61,61,61',1);//PIP                        
  //SetText("Pp1"+IntegerToString(i),0,c_axis+250,(i*12)+cc_axis+234,PipsColor,6);//
  SetPanel("A03"+IntegerToString(i),0,c_axis+270,(i*12)+cc_axis+234,15,10,clrBlack,C'61,61,61',1);//ADR
  SetText("S1"+IntegerToString(i),0,c_axis+270,(i*12)+cc_axis+234,Yellow,6);//
  SetPanel("A04"+IntegerToString(i),0,c_axis+285,(i*12)+cc_axis+234,20,10,clrBlack,C'61,61,61',1);//RATIO           
  SetPanel("A05"+IntegerToString(i),0,c_axis+305,(i*12)+cc_axis+234,10,10,clrBlack,C'61,61,61',1);//SIG RATIO
  SetPanel("A06"+IntegerToString(i),0,c_axis+315,(i*12)+cc_axis+234,15,10,clrBlack,C'61,61,61',1);//BSR
  SetPanel("A07"+IntegerToString(i),0,c_axis+330,(i*12)+cc_axis+234,10,10,clrBlack,C'61,61,61',1);//CTRAND
  SetObjText("Ctrand"+IntegerToString(i),CharToStr(159),c_axis+333,(i*12)+cc_axis+234,clrNONE,6);
  SetPanel("A08"+IntegerToString(i),0,c_axis+340,(i*12)+cc_axis+234,10,10,clrBlack,C'61,61,61',1);//STR
  SetPanel("A09"+IntegerToString(i),0,c_axis+350,(i*12)+cc_axis+234,20,10,clrBlack,C'61,61,61',1);//PREV.GAP
  SetPanel("GAP123"+IntegerToString(i),0,c_axis+370,(i*12)+cc_axis+234,40,10,clrBlack,C'61,61,61',1);
  //SetPanel("A10"+IntegerToString(i),0,c_axis+370,(i*12)+cc_axis+234,20,10,clrBlack,C'61,61,61',1);//GAP
  //SetPanel("B01"+IntegerToString(i),0,c_axis+390,(i*12)+cc_axis+234,10,10,clrBlack,C'61,61,61',1);//SIG GAP
  SetPanel("B02"+IntegerToString(i),0,c_axis+400,(i*12)+cc_axis+234,10,10,clrBlack,C'61,61,61',1);//SIG P
  SetPanel("B03"+IntegerToString(i),0,c_axis+410,(i*12)+cc_axis+234,10,10,clrBlack,C'61,61,61',1);//INTRADAY
  SetPanel("B04"+IntegerToString(i),0,c_axis+420,(i*12)+cc_axis+234,10,10,clrBlack,C'61,61,61',1);//OpTrend
  SetPanel("B05"+IntegerToString(i),0,c_axis+430,(i*12)+cc_axis+234,10,10,clrBlack,C'61,61,61',1);//ADR SIG
  //SetPanel("B06"+IntegerToString(i),0,x_axis+545,(i*12)+y_axis+234,35,12,clrBlack,clrDimGray,1);//CAIXA LOTES
  //SetPanel("B07"+IntegerToString(i),0,x_axis+655,(i*12)+y_axis+234,35,12,clrBlack,clrDimGray,1);//CAIXA LOTES
  SetPanel("bb"+IntegerToString(i),0,c_axis+440,(i*12)+cc_axis+234,10,10,clrBlack,C'61,61,61',1);    
  SetObjText("bbTouch"+IntegerToString(i),CharToStr(104),c_axis+440,(i*12)+cc_axis+234,clrNONE,6);
  
  SetText("Rep_01","MINPROFIT",x_axis+1207,y_axis+365,clrGold,6);
  SetText("Rep_Symb","Symbol",x_axis+1207,y_axis+325,clrGold,8);  
  SetText("NewOrder","Hedge Order",x_axis+1207,y_axis+340,clrKhaki,8); 
  SetText("Hedge","Hedge",x_axis+1207,y_axis+355,clrKhaki,8);   
  
//  SetPanel("PointRange"+IntegerToString(i),0,x_axis+740,(i*12)+y_axis+234,15,12,C'20,20,20',C'20,20,20',0);
//  SetPanel("High"+IntegerToString(i),0,x_axis+765,(i*12)+y_axis+234,35,12,C'20,20,20',C'20,20,20',0); 
//  SetPanel("Ask"+IntegerToString(i),0,x_axis+805,(i*12)+y_axis+234,35,12,C'20,20,20',C'20,20,20',0);        
//  SetPanel("Bid"+IntegerToString(i),0,x_axis+845,(i*12)+y_axis+234,35,12,C'20,20,20',C'20,20,20',0);
//  SetPanel("Low"+IntegerToString(i),0,x_axis+885,(i*12)+y_axis+234,35,12,C'20,20,20',C'20,20,20',0);
//USD 1
  SetPanel("A1"+IntegerToString(i),0,(i*47)+x_axis+2,y_axis+672,25,10,C'0,0,0',C'0,0,0',1);
  //SetPanel("A2"+IntegerToString(i),0,x_axis+1170,(i*12)+y_axis+234,37,12,C'0,0,0',C'0,0,0',1);            
  SetPanel("DIR"+IntegerToString(i),0,(i*47)+x_axis+27,y_axis+672,12,11,C'0,0,0',C'0,0,0',1);//USD
  SetPanel("B11"+IntegerToString(i),0,(i*47)+x_axis+2,y_axis+672,3,10,C'0,0,0',C'0,0,0',1); 
  SetPanel("B21"+IntegerToString(i),0,(i*47)+x_axis+4,y_axis+672,3,10,C'0,0,0',C'0,0,0',1); 
  SetPanel("B31"+IntegerToString(i),0,(i*47)+x_axis+6,y_axis+672,3,10,labelcolor4,labelcolor2,1);
  SetPanel("B41"+IntegerToString(i),0,(i*47)+x_axis+8,y_axis+672,3,10,labelcolor5,labelcolor2,1);
  SetPanel("B51"+IntegerToString(i),0,(i*47)+x_axis+10,y_axis+672,3,10,labelcolor6,labelcolor2,1);
  SetPanel("B61"+IntegerToString(i),0,(i*47)+x_axis+12,y_axis+672,3,10,labelcolor7,labelcolor2,1);
  SetPanel("B71"+IntegerToString(i),0,(i*47)+x_axis+14,y_axis+672,3,10,labelcolor8,labelcolor2,1);
  SetPanel("B81"+IntegerToString(i),0,(i*47)+x_axis+16,y_axis+672,3,10,labelcolor9,labelcolor2,1);
  SetPanel("B91"+IntegerToString(i),0,(i*47)+x_axis+18,y_axis+672,3,10,labelcolor10,labelcolor2,1);
  SetPanel("B101"+IntegerToString(i),0,(i*47)+x_axis+20,y_axis+672,3,10,labelcolor11,labelcolor2,1);

  //SetPanel("A2"+IntegerToString(i),0,x_axis+950,(i*12)+y_axis+234,255,12,C'30,30,30',C'61,61,61',1);//COR FUNDO PAINEL LOTES          
  int               b_axis                           = 470         ;//Ajustar para esquerda/direita
  int               bb_axis                          = -65       ;//Ajustar para cima/baixo
  //SetPanel("A222"+IntegerToString(i),0,c_axis-640,(i*12)+cc_axis+234,805,9,clrBlack,C'61,61,61',1);//COLUNA LOTES ORDEM LINHAS / LINHA VERDE
  //SetPanel("B2222"+IntegerToString(i),0,c_axis-640,(i*12)+cc_axis+234,805,9,clrBlack,C'61,61,61',1);//COLUNA LOTES ORDEM LINHAS / LINHA VERDE
  SetPanel("A2223"+IntegerToString(i),0,(i*47)+c_axis-644,cc_axis+690,35,10,clrBlack,C'61,61,61',1);//COLUNA LOTES ORDEM LINHAS / LINHA VERDE
  SetPanel("B22223"+IntegerToString(i),0,(i*47)+c_axis-644,cc_axis+690,35,10,clrBlack,C'61,61,61',1);//COLUNA LOTES ORDEM LINHAS / LINHA VERDE
  SetPanel("A222333"+IntegerToString(i),0,c_axis+235,(i*12)+cc_axis+234,15,9,clrBlack,C'61,61,61',1);//COLUNA LOTES ORDEM LINHAS / LINHA VERDE
  SetPanel("B2222333"+IntegerToString(i),0,c_axis+235,(i*12)+cc_axis+234,15,9,clrBlack,C'61,61,61',1);//COLUNA LOTES ORDEM LINHAS / LINHA VERDE
  
/*  //SIGNAL INTRADAY
  SetPanel("ha4"+IntegerToString(i),0,x_axis+811,(i*12)+y_axis+234,12,12,C'20,20,20',C'61,61,61',1);
  SetPanel("had1"+IntegerToString(i),0,x_axis+823,(i*12)+y_axis+234,12,12,C'20,20,20',C'61,61,61',1);
  SetText("Signal","Intra    Daily",x_axis+810,y_axis+210,White,8);
  ObjectDelete("Pips"+IntegerToString(i));ObjectDelete("Sig"+IntegerToString(i));ObjectDelete("SGD"+IntegerToString(i));
  ObjectDelete("M1sig"+IntegerToString(i));ObjectDelete("M5sig"+IntegerToString(i));ObjectDelete("M15sig"+IntegerToString(i));
  ObjectDelete("M30sig"+IntegerToString(i));ObjectDelete("H1sig"+IntegerToString(i));ObjectDelete("H4sig"+IntegerToString(i));
  ObjectDelete("D1sig"+IntegerToString(i));ObjectDelete("W1sig"+IntegerToString(i));ObjectDelete("Mnsig"+IntegerToString(i));
*/      
//BOTAO LOTES
//panel box for Auto Pending Orders 

  SetPanel("H_Inputs",0,a_axis+668,aa_axis+117,93,95,clrGoldenrod,White,1);//inputs box for HARE LOTS,SL,TP
  SetText("H_In1","LOT/STOP per PIP",a_axis+671,aa_axis+116,Black,7);
  SetText("LotSize","LotSize",a_axis+671,aa_axis+127,White,8);
  SetPanel("H_Lots_P",0,a_axis+718,aa_axis+127,40,14,clrBlack,Black,1);
  Create_Button(button_increase_lot,"+",13,13,z_axis+722,aa_axis+142,clrGainsboro,clrWhite);
  Create_Button(button_decrease_lot,"-",13,13,z_axis+740,aa_axis+142,clrGainsboro,clrWhite);
  //Create_Button(button_H3,"+",12,12,z_axis+641,aa_axis+34,clrGainsboro,clrWhite);
  //Create_Button(button_H4,"-",12,12,z_axis+655,aa_axis+34,clrGainsboro,clrWhite);
  //Create_Button(button_H5,"+",12,12,z_axis+641,aa_axis+48,clrGainsboro,clrWhite);
  //Create_Button(button_H6,"-",12,12,z_axis+655,aa_axis+48,clrGainsboro,clrWhite);         
  //Create_Button(button_H7,"+",12,12,z_axis+641,aa_axis+62,clrGainsboro,clrWhite);
  //Create_Button(button_H8,"-",12,12,z_axis+655,aa_axis+62,clrGainsboro,clrWhite);
  SetText("Piptp","TP",a_axis+676,aa_axis+182,Black,8);
  SetPanel("H_TP_P",0,a_axis+718,aa_axis+156,40,14,clrBlack,White,1);
  Create_Button(button_increase_Piptp,"+",13,13,z_axis+722,aa_axis+170,clrGainsboro,clrWhite);
  Create_Button(button_decrease_Piptp,"-",13,13,z_axis+740,aa_axis+170,clrGainsboro,clrWhite);
  SetText("Pipsl","SL",a_axis+676,aa_axis+196,Black,8);
  SetPanel("H_SL_P",0,a_axis+718,aa_axis+184,40,14,clrBlack,White,1);
  Create_Button(button_increase_Pipsl,"+",13,13,z_axis+722,aa_axis+197,clrGainsboro,clrWhite);
  Create_Button(button_decrease_Pipsl,"-",13,13,z_axis+740,aa_axis+197,clrGainsboro,clrWhite);
  //SetText("H_In5",DoubleToStr(H_Lot,2),a_axis+610,aa_axis+20,clrWhite,8);         
  SetText("Piptp",IntegerToString(H_TP),a_axis+671,aa_axis+156,clrWhite,8);
  SetText("Pipsl",IntegerToString(H_SL),a_axis+671,aa_axis+184,clrWhite,8);
  
//panel box for Basket Trades & Single Trades        
  SetPanel("S_BAS_Inputs",0,a_axis+668,aa_axis+358,93,95,clrGoldenrod,White,1);//inputs box for SINGLE and BASKET LOTS,SL,TP
  SetText("S_BAS_In1","STOP por ADR",a_axis+670,aa_axis+360,Black,7);
  //SetText("LotSize1","Lot",a_axis+576,aa_axis+342,White,8);
  //SetPanel("S_BAS_Lots_P",0,a_axis+623,aa_axis+341,40,14,clrBlack,White,1);
  //Create_Button(button_SB1,"+",13,13,z_axis+627,aa_axis+356,clrGainsboro,clrWhite);
  //Create_Button(button_SB2,"-",13,13,z_axis+645,aa_axis+356,clrGainsboro,clrWhite);
  //Create_Button(button_SB3,"+",12,12,z_axis+641,aa_axis+359,clrGainsboro,clrWhite);
  //Create_Button(button_SB4,"-",12,12,z_axis+655,aa_axis+359,clrGainsboro,clrWhite);
  //Create_Button(button_SB5,"+",12,12,z_axis+641,aa_axis+373,clrGainsboro,clrWhite);
  //Create_Button(button_SB6,"-",12,12,z_axis+655,aa_axis+373,clrGainsboro,clrWhite);         
  //Create_Button(button_SB7,"+",12,12,z_axis+641,aa_axis+387,clrGainsboro,clrWhite);
  //Create_Button(button_SB8,"-",12,12,z_axis+655,aa_axis+387,clrGainsboro,clrWhite);
  SetText("Adr1tp","TP",a_axis+676,aa_axis+357,Black,8);
  SetPanel("S_BAS_TP_P",0,a_axis+718,aa_axis+396,40,14,clrBlack,White,1);
  Create_Button(button_increase_Adr1tp,"+",13,13,z_axis+722,aa_axis+411,clrGainsboro,clrWhite);
  Create_Button(button_decrease_Adr1tp,"-",13,13,z_axis+740,aa_axis+411,clrGainsboro,clrWhite);
  SetText("Adr1sl","SL",a_axis+675,aa_axis+295,Black,8);
  SetPanel("S_BS_SL_P",0,a_axis+718,aa_axis+425,40,14,clrBlack,White,1);
  Create_Button(button_increase_Adr1sl,"+",13,13,z_axis+722,aa_axis+439,clrGainsboro,clrWhite);
  Create_Button(button_decrease_Adr1sl,"-",13,13,z_axis+740,aa_axis+439,clrGainsboro,clrWhite);
  //SetText("S_BAS_In5",DoubleToStr(S_BS_Lot,2),a_axis+610,aa_axis+345,clrWhite,8);         
  SetText("Adr1tp",IntegerToString(S_BS_TP),a_axis+671,aa_axis+396,clrWhite,8);
  SetText("Adr1sl",IntegerToString(S_BS_SL),a_axis+671,aa_axis+425,clrWhite,8);
//   
  //SetPanel("TP1",0,x_axis+122,y_axis+288,125,20,Black,White,1); //these move the "Monitoring Trade" boxes
  //SetPanel("TP2",0,x_axis+122,y_axis+307,125,20,Black,White,1);
  //SetPanel("TP3",0,x_axis+122,y_axis+326,125,20,Black,White,1);
//BOTAO LOTES         

  //SetText("Direct","High     Ask    Bid      Low",x_axis+991,y_axis+210,Gray,8);
  //SetText("Trend","Range",x_axis+1130,y_axis+210,Gray,8);
  //SetText("Symbol","Point",x_axis+1130,y_axis+220,Gray,8);       
  //SetText("bLots"+IntegerToString(i),DoubleToStr(blots[i],2),x_axis+1095,(i*12)+y_axis+234,C'61,61,61',6);//TEXTO LOTES       
  //SetText("bLots"+IntegerToString(i),DoubleToStr(blots[i],2),(i*47)+x_axis+5,y_axis+615,C'61,61,61',5);//TEXTO LOTES
  //SetText("sLots"+IntegerToString(i),DoubleToStr(slots[i],2),x_axis+1115,(i*12)+y_axis+234,C'61,61,61',6);//TEXTO LOTES
  //SetText("sLots"+IntegerToString(i),DoubleToStr(slots[i],2),(i*47)+x_axis+20,+y_axis+615,C'61,61,61',5);//TEXTO LOTES
  SetText("bPos"+IntegerToString(i),DoubleToStr(bpos[i],0),c_axis+217,(i*12)+cc_axis+234,C'61,61,61',6);//TEXTO LOTES
  SetText("sPos"+IntegerToString(i),DoubleToStr(spos[i],0),c_axis+225,(i*12)+cc_axis+234,C'61,61,61',6);//TEXTO LOTES
  //SetText("TProf"+IntegerToString(i),DoubleToStr(MathAbs(bprofit[i]),2),x_axis+1090,(i*12)+y_axis+234,C'61,61,61',8);//TEXTO LOTES
  //SetText("SProf"+IntegerToString(i),DoubleToStr(MathAbs(sprofit[i]),2),x_axis+1130,(i*12)+y_axis+234,C'61,61,61',8);//TEXTO LOTES
  //SetText("TtlProf"+IntegerToString(i),DoubleToStr(MathAbs(tprofit[i]),2),(i*47)+x_axis+5,y_axis+605,C'61,61,61',6);//TEXTO TOTAL LUCRO PAR
  SetText("TtlProf"+IntegerToString(i),DoubleToStr(MathAbs(tprofit[i]),2),x_axis+1185,(i*12)+y_axis+234,C'61,61,61',6);//TEXTO TOTAL LUCRO PAR
  SetText("TotProf",DoubleToStr(MathAbs(totalprofit),2),x_axis+1233,y_axis+80,ProfitColor1,15);//TEXTO TOTAL GAISN/LOOS         
  
//  SetText("Highest","Highest= "+DoubleToStr(SymbolMaxHi,2)+" ("+DoubleToStr(PercentFloatingSymbol,2)+"%)",x_axis+1000,y_axis+180,BullColor,8);
//  SetText("Won",IntegerToString(profitbaskets,2),x_axis+1150,y_axis+180,BullColor,8);
//  SetText("Lock","Lock= "+DoubleToStr(currentlock,2),x_axis+1000,y_axis+195,BullColor,8);
//  SetText("Lowest","Lowest= "+DoubleToStr(SymbolMaxDD,2)+" ("+DoubleToStr(PercentMaxDDSymbol,2)+"%)",x_axis+1000,y_axis+210,BearColor,8);  
//  SetText("Lost",IntegerToString(lossbaskets,2),x_axis+1150,y_axis+210,BearColor,8);

  SetText("usdintsig"+IntegerToString(i),DoubleToStr(MathAbs(signals[i].Signalusd),0)+"%",(i*47)+x_axis+2,y_axis+680,Color9,6);
             
  SetText("Pr123"+IntegerToString(i),StringSubstr(TradePairs[i],0,6),(i*47)+x_axis+5,y_axis+600,clrYellow,6);//BOTAO PAR COLUNA HEAT MAP
//  SetText("Pr1234"+IntegerToString(i),StringSubstr(TradePairs[i],0,6),x_axis+975,(i*12)+y_axis+233,clrYellow,8);//BOTAO PAR COLUNA 3 POINTRANGE
//  SetText("Pr12345"+IntegerToString(i),StringSubstr(TradePairs[i],0,6),x_axis+1125,(i*12)+y_axis+234,clrYellow,8);//BOTAO PAR COLUNA LOTES

  }

  //SetText("TPr","Basket TakeProfit =$ "+DoubleToStr(Basket_Target,0),x_axis+5,y_axis+210,Yellow,8);
  //SetText("SL","Basket StopLoss =$ -"+DoubleToStr(Basket_StopLoss,0),x_axis+185,y_axis+210,Yellow,8);                 
  //SetText("TTr","B.Lot     S.Lot",x_axis+1060,y_axis+635,White,8);
  //SetText("Trades","Buy Sell  Buy       Sell        Prof",x_axis+1133,y_axis+635,White,8);

/*//BOTAO LOTES
   Create_Button(button_increase_lot,CharToStr(225),15,12,x_axis+169,y_axis+437,C'35,35,35',clrWhite,clrGreen,"Wingdings",8);
   Create_Button("LotSize","",76,12,x_axis+184,y_axis+437,C'35,35,35',clrWhite);
   Create_Button(button_decrease_lot,CharToStr(226),15,12,x_axis+260,y_axis+437,C'35,35,35',clrWhite,clrRed,"Wingdings",8); 
//BOTAO LOTES
//BOTAO STOPS
   Create_Button(button_increase_Adr1tp,CharToStr(225),15,12,x_axis+250,y_axis+331,C'35,35,35',clrWhite,clrGreen,"Wingdings",8);
   Create_Button("Adr1tp","",76,12,x_axis+265,y_axis+331,C'35,35,35',clrWhite);
   Create_Button(button_decrease_Adr1tp,CharToStr(226),15,12,x_axis+340,y_axis+331,C'35,35,35',clrWhite,clrRed,"Wingdings",8);
   
   Create_Button(button_increase_Adr1sl,CharToStr(225),15,12,x_axis+250,y_axis+343,C'35,35,35',clrWhite,clrGreen,"Wingdings",8);
   Create_Button("Adr1sl","",76,12,x_axis+265,y_axis+343,C'35,35,35',clrWhite);
   Create_Button(button_decrease_Adr1sl,CharToStr(226),15,12,x_axis+340,y_axis+343,C'35,35,35',clrWhite,clrRed,"Wingdings",8);   
//---    
   Create_Button(button_increase_Piptp,CharToStr(225),15,12,x_axis+250,y_axis+532,C'35,35,35',clrWhite,clrGreen,"Wingdings",8);
   Create_Button("Piptp","",76,12,x_axis+265,y_axis+532,C'35,35,35',clrWhite);
   Create_Button(button_decrease_Piptp,CharToStr(226),15,12,x_axis+340,y_axis+532,C'35,35,35',clrWhite,clrRed,"Wingdings",8);
   
   Create_Button(button_increase_Pipsl,CharToStr(225),15,12,x_axis+250,y_axis+544,C'35,35,35',clrWhite,clrGreen,"Wingdings",8);
   Create_Button("Pipsl","",76,12,x_axis+265,y_axis+544,C'35,35,35',clrWhite);
   Create_Button(button_decrease_Pipsl,CharToStr(226),15,12,x_axis+340,y_axis+544,C'35,35,35',clrWhite,clrRed,"Wingdings",8);
//BOTAO STOPS*/   
//BOTAO ACCOUNT MANAGER 
Create_Button("button_trigger_use_ShowAccountOrderInfo","AccountOrder",75 ,12,x_axis+553 ,y_axis+700,Black,White);//BOTAO ACCOUNT MANAGER 
Create_Button("button_trigger_use_ShowTodayRanges","TodayRanges",75 ,12,x_axis+628 ,y_axis+700,Black,White);//BOTAO ACCOUNT MANAGER
Create_Button("button_trigger_use_ShowProfitInfo","ProfitInfo",75 ,12,x_axis+703 ,y_axis+700,Black,White);//BOTAO ACCOUNT MANAGER
Create_Button("button_trigger_use_ShowRiskInfo","RiskInfo",75 ,12,x_axis+778 ,y_axis+700,Black,White);//BOTAO ACCOUNT MANAGER
//BOTAO ACCOUNT MANAGER 
//Create_Button("button_trigger_use_PARES1","Pares",50 ,10,x_axis+5 ,y_axis+222,Black,White);//PARES FAKE
Create_Button("button_trigger_use_bidratio00","Bidratio",95 ,12,x_axis+5 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_bidratio11","Bidratio",95 ,12,x_axis+120 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_bidratio22","Bidratio",95 ,12,x_axis+235 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_bidratio33","Bidratio",95 ,12,x_axis+350 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_bidratio44","Bidratio",95 ,12,x_axis+465 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_bidratio55","Bidratio",95 ,12,x_axis+580 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_bidratio66","Bidratio",95 ,12,x_axis+695 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_pips00","P",20 ,12,x_axis+100 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_pips11","P",20 ,12,x_axis+215 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_pips22","P",20 ,12,x_axis+330 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_pips33","P",20 ,12,x_axis+445 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_pips44","P",20 ,12,x_axis+560 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_pips55","P",20 ,12,x_axis+675 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_pips66","P",20 ,12,x_axis+790 ,y_axis+222,Black,White);
//Create_Button("button_trigger_use_relstrength00","Str",20 ,12,x_axis+80 ,y_axis+222,Black,White);
//Create_Button("button_trigger_use_relstrength11","Str",20 ,12,x_axis+175 ,y_axis+222,Black,White);
//Create_Button("button_trigger_use_relstrength22","Str",20 ,12,x_axis+270 ,y_axis+222,Black,White);
//Create_Button("button_trigger_use_relstrength33","Str",20 ,12,x_axis+365 ,y_axis+222,Black,White);
//Create_Button("button_trigger_use_relstrength44","Str",20 ,12,x_axis+460 ,y_axis+222,Black,White);
//Create_Button("button_trigger_use_relstrength55","Str",20 ,12,x_axis+555 ,y_axis+222,Black,White);
//Create_Button("button_trigger_use_relstrength66","Str",20 ,12,x_axis+650 ,y_axis+222,Black,White);
//Create_Button("button_trigger_use_Pips1","Pip",20 ,10,x_axis+145 ,y_axis+222,Black,White);//PIP FAKE
//Create_Button("button_trigger_use_Pips","PIP",20 ,12,x_axis+5 ,y_axis+76,Black,White);//
Create_Button("button_trigger_use_ADR","AD",20 ,12,x_axis+910 ,y_axis+222,Black,White);//ADR FAKE
Create_Button("button_trigger_use_bidratio","BDR",30 ,12,x_axis+930 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_buysellratio","BS",25 ,12,x_axis+960 ,y_axis+222,Black,White);
//Create_Button("button_trigger_use_C_Trand","CT",10 ,12,x_axis+785 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_relstrength","S",10 ,12,x_axis+985 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_SigGapPrev","SG",20 ,12,x_axis+995 ,y_axis+222,Black,White);//Prev.Gap FAKE
Create_Button("button_trigger_use_gap","GP",30 ,12,x_axis+1015 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_INTRADAY",".",20 ,12,x_axis+1045 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_OT",".",10 ,12,x_axis+1065 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_ADR1",".",10 ,12,x_axis+1075 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_BB",".",10 ,12,x_axis+1085 ,y_axis+222,Black,White);
Create_Button("button_trigger_use_Strength","USD",50 ,12,x_axis+860 ,y_axis+222,Black,White);//USD 01
//Create_Button("button_trigger_Candle_DirectionFAKE","Candle",36 ,12,x_axis+615 ,y_axis+212,Black,White); //BOTAO FAKE
Create_Button("button_trigger_Candle_Direction","CD",35 ,12,x_axis+1095 ,y_axis+222,Black,White);

//Create_Button("button_FAKE","Heat Map",150 ,12,x_axis+803 ,y_axis+212,Black,White);//Heat Map FAKE
Create_Button("button_trigger_UseHeatMap1","HM M15",50 ,12,x_axis+303 ,y_axis+700,Black,White);
Create_Button("button_trigger_UseHeatMap2","HM M30",50 ,12,x_axis+353 ,y_axis+700,Black,White);
Create_Button("button_trigger_UseHeatMap3","HM H1",50 ,12,x_axis+403 ,y_axis+700,Black,White);
Create_Button("button_trigger_UseHeatMap4","HM H4",50 ,12,x_axis+453 ,y_axis+700,Black,White);
Create_Button("button_trigger_UseHeatMap5","HM D1",50 ,12,x_axis+503 ,y_axis+700,Black,White);
   
/*Create_Button("button_FAKEMM12","Média Móvel",300 ,12,x_axis+1000 ,y_axis+130,Black,White); //BOTAO FAKE
//MM12   
Create_Button("button_trigger_Moving_Average1","30",20 ,12,x_axis+1000 ,y_axis+140,Black,White);//MM12 30
Create_Button("button_trigger_Moving_Average2","30",20 ,12,x_axis+1020 ,y_axis+140,Black,White);//MM12 H1
Create_Button("button_trigger_Moving_Average3","30",20 ,12,x_axis+1040 ,y_axis+140,Black,White);//MM12 H4 

//Create_Button("button_FAKEMM21","MM21",60 ,17,m_axis+510 ,n_axis+85,Black,White); //BOTAO FAKE
//MM21 
Create_Button("button_trigger_Moving_Average4","45",20 ,12,x_axis+1060 ,y_axis+140,Black,White);//MM21 30
Create_Button("button_trigger_Moving_Average5","45",20 ,12,x_axis+1080 ,y_axis+140,Black,White);//MM21 H1
Create_Button("button_trigger_Moving_Average6","45",20 ,12,x_axis+1100 ,y_axis+140,Black,White);//MM21 H4

//Create_Button("button_FAKEMM30","MM30",60 ,17,m_axis+570 ,n_axis+60,Black,White); //BOTAO FAKE
//MM30
Create_Button("button_trigger_Moving_Average7","60",20 ,12,x_axis+1120 ,y_axis+140,Black,White);//MM30 30
Create_Button("button_trigger_Moving_Average8","60",20 ,12,x_axis+1140 ,y_axis+140,Black,White);//MM30 H1
Create_Button("button_trigger_Moving_Average9","60",20 ,12,x_axis+1160 ,y_axis+140,Black,White);//MM30 H4

//Create_Button("button_FAKEMM50","MM50",60 ,17,x_axis+630 ,n_axis+60,Black,White); //BOTAO FAKE
//MM50
Create_Button("button_trigger_Moving_Average10","75",20 ,12,x_axis+1180 ,y_axis+140,Black,White);//MM50 30
Create_Button("button_trigger_Moving_Average11","75",20 ,12,x_axis+1200 ,y_axis+140,Black,White);//MM50 H1
Create_Button("button_trigger_Moving_Average12","75",20 ,12,x_axis+1220 ,y_axis+140,Black,White);//MM50 H4

//Create_Button("button_FAKEMM100","MM100",60 ,17,m_axis+690 ,n_axis+60,Black,White); //BOTAO FAKE
//MM100
Create_Button("button_trigger_Moving_Average13","90",20 ,12,x_axis+1240 ,y_axis+140,Black,White);//MM100 30
Create_Button("button_trigger_Moving_Average14","90",20 ,12,x_axis+1260 ,y_axis+140,Black,White);//MM100 H1
Create_Button("button_trigger_Moving_Average15","90",20 ,12,x_axis+1280 ,y_axis+140,Black,White);//MM100 H4


//Create_Button("button_1","CCI",41 ,12,x_axis+989 ,y_axis+150,Black,Yellow);//CCI FAKE
//Create_Button("button_2","RSI",41 ,12,x_axis+1030 ,y_axis+150,Black,Yellow);//RSI FAKE
//Create_Button("button_3","MACD",41 ,12,x_axis+1071 ,y_axis+150,Black,Yellow);//MACD FAKE
Create_Button("button_UseCCI1","CCI",33 ,12,x_axis+1000 ,y_axis+150,Black,White);//CCI M30 
Create_Button("button_UseCCI2","CCI",33 ,12,x_axis+1033 ,y_axis+150,Black,White);//CCI H1
Create_Button("button_UseCCI3","CCI",33 ,12,x_axis+1066 ,y_axis+150,Black,White);//CCI H4
Create_Button("button_UseRSI1","RSI",33 ,12,x_axis+1099 ,y_axis+150,Black,White);//RSI M30
Create_Button("button_UseRSI2","RSI",33 ,12,x_axis+1133 ,y_axis+150,Black,White);//RSI H1
Create_Button("button_UseRSI3","RSI",33 ,12,x_axis+1168 ,y_axis+150,Black,White);//RSI H4
Create_Button("button_trigger_MACD1","MACD",33 ,12,x_axis+1201 ,y_axis+150,Black,White);//MACD M30
Create_Button("button_trigger_MACD2","MACD",33 ,12,x_axis+1234 ,y_axis+150,Black,White);//MACD H1
Create_Button("button_trigger_MACD3","MACD",33 ,12,x_axis+1267 ,y_axis+150,Black,White);//MACD H4
*/
//SESSOES
Create_Button("button_trigger_use_TRADING","Santos",50 ,12,x_axis+810 ,y_axis+222,Black,Lime);//TRADING/CLOSE
Create_Button("button_UseSession4","00/04Hr",50 ,12,x_axis+3 ,y_axis+700,Black,White);//SESSAO LONDRES
Create_Button("button_UseSession5","04/08Hr",50 ,12,x_axis+53 ,y_axis+700,Black,White);//SESSAO TOKIO
Create_Button("button_UseSession6","08/12Hr",50 ,12,x_axis+103 ,y_axis+700,Black,White);//SESSAO NOVA YORK
Create_Button("button_UseSession1","12/16Hr",50 ,12,x_axis+153 ,y_axis+700,Black,White);//SESSAO LONDRES
Create_Button("button_UseSession2","16/20Hr",50 ,12,x_axis+203 ,y_axis+700,Black,White);//SESSAO TOKIO
Create_Button("button_UseSession3","20/24Hr",50,12,x_axis+253 ,y_axis+700,Black,White);//SESSAO NOVA YORK

Create_Button("button_autotrade","Manual",95 ,12,x_axis+1207 ,y_axis+412,Black,clrGreen);//AUTOTRADE/MANUAL
Create_Button(button_close_basket_Prof,"CLOSE PROFIT",95 ,12,x_axis+1207 ,y_axis+424,Black,clrLime);//
Create_Button(button_close_basket_Loss,"CLOSE LOSS",95 ,12,x_axis+1207 ,y_axis+436,Black,clrRed);//
Create_Button(button_close_basket_All,"CLOSE ALL",95 ,12,x_axis+1207 ,y_axis+448,Black,clrWhite);//
Create_Button(button_reset_ea,"RESET EA",95 ,12,x_axis+1207 ,y_axis+460,Black,clrYellow);//

  newday = 0;
  newm1=0;

/*  HP  */
  localday = 99;
  s1active = false;
  s2active = false;
  s3active = false;
  s4active = false;
  s5active = false;
  s6active = false;
  trailstarted = false;

  if (MaxTotalTrades == 0)
  maxtotaltrades = ArraySize(TradePairs) * MaxTrades;
  else
  maxtotaltrades = MaxTotalTrades;
                
/*  HP  */
  EventSetTimer(1);

  return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
  EventKillTimer();
  ObjectsDeleteAll();
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer() {

  //clock();       
  DoWork();
  GetTrendChange();
  Trades();
  TradeManager();
  get_list_status00(list00);
  get_list_status11(list11);
  get_list_status22(list22);
  get_list_status33(list33);
  get_list_status44(list44);
  get_list_status55(list55);
  get_list_status66(list66);
  PlotTrades();
  PlotSpreadPips();
  GetSignals();
  GetSignals2();
  GetSignals00();
  GetSignals11();
  GetSignals22();
  GetSignals33();
  GetSignals44();
  GetSignals55();
  GetSignals66();  
  displayMeter();
  displayMeter00();
  displayMeter11();
  displayMeter22();
  displayMeter33();
  displayMeter44();
  displayMeter55();
  displayMeter66();
  //displayMeter1();  
  GetCommodity();
  GetCommodity1();
  GetCommodity2();
  GetCommodity3();
  GetTrendChangeRSI();
   
  if (newday != iTime("AUDNZD"+postfix,PERIOD_D1,0))
  {
  GetAdrValues();
  PlotAdrValues();
  newday = iTime("AUDNZD"+postfix,PERIOD_D1,0);
//  if(DaySearch()==0)
//  { GetMatrix(0,x_axis+998,y_axis+234,8,12,8,C'61,61,61'); 
//  }
  }
  if (DashUpdate == 0 || (DashUpdate == 1 && newm1 != iTime("AUDNZD"+postfix,PERIOD_M1,0)) || (DashUpdate == 5 && newm1 != iTime("AUDNZD"+postfix,PERIOD_M5,0)))
  {
  
//INTRADAY
//  symb_cnt=StringSplit(Pairs,u_sep,TradePairs);
  
  for(int i=0;i<ArraySize(TradePairs);i++)
  {
  if(iClose(TradePairs[i],0,0) > 0) 
  {      
  for(int e=0;e<ArraySize(period1);e++)
  {
  TradePairs[i] = StringConcatenate(suffix,TradePairs[i],suffix);
  if(Point==0.0001 || Point==0.01) 
  {
  PairPip=MarketInfo(TradePairs[i] ,MODE_POINT);
  pipsfactor=1;
  } 
  else if(Point==0.00001 || Point==0.001) 
  {
  PairPip=MarketInfo(TradePairs[i] ,MODE_POINT)*10;
  pipsfactor=10;
  }
  
  if(MarketInfo(TradePairs[i],MODE_POINT) != 0 && pipsfactor != 0) 
  {
  Pips[i]=(iClose(TradePairs[i],PERIOD_D1,0)-iOpen(TradePairs[i], PERIOD_D1,0))/MarketInfo(TradePairs[i],MODE_POINT)/pipsfactor;     
  Spread[i]=MarketInfo(TradePairs[i],MODE_SPREAD)/pipsfactor; 
  }  
  
  double Openm1    = iMA(TradePairs[i], PERIOD_M1,3,0,MODE_SMA,PRICE_CLOSE,3);
  double Closem1   = iMA(TradePairs[i], PERIOD_M1,3,0,MODE_SMA,PRICE_CLOSE,0);
  double Openm5    = iMA(TradePairs[i], PERIOD_M5,3,0,MODE_SMA,PRICE_CLOSE,3);
  double Closem5   = iMA(TradePairs[i], PERIOD_M5,3,0,MODE_SMA,PRICE_CLOSE,0);
  double Openm15   = iMA(TradePairs[i], PERIOD_M15,3,0,MODE_SMA,PRICE_CLOSE,3);
  double Closem15  = iMA(TradePairs[i], PERIOD_M15,3,0,MODE_SMA,PRICE_CLOSE,0);
  double Openm30   = iMA(TradePairs[i], PERIOD_M30,3,0,MODE_SMA,PRICE_CLOSE,3);
  double Closem30  = iMA(TradePairs[i], PERIOD_M30,3,0,MODE_SMA,PRICE_CLOSE,0);
  double Openh1    = iMA(TradePairs[i], PERIOD_H1,3,0,MODE_SMA,PRICE_CLOSE,3);
  double Closeh1   = iMA(TradePairs[i], PERIOD_H1,3,0,MODE_SMA,PRICE_CLOSE,0);
  double Open4     = iMA(TradePairs[i], PERIOD_H4,3,0,MODE_SMA,PRICE_CLOSE,3);
  double Close4    = iMA(TradePairs[i], PERIOD_H4,3,0,MODE_SMA,PRICE_CLOSE,0);      
  double Opend1    = iMA(TradePairs[i], PERIOD_D1,3,0,MODE_SMA,PRICE_CLOSE,3);
  double Closed1   = iMA(TradePairs[i], PERIOD_D1,3,0,MODE_SMA,PRICE_CLOSE,0);      
  double Openw     = iMA(TradePairs[i], PERIOD_W1,3,0,MODE_SMA,PRICE_CLOSE,3);
  double Closew    = iMA(TradePairs[i], PERIOD_W1,3,0,MODE_SMA,PRICE_CLOSE,0);
  double Openmn    = iMA(TradePairs[i], PERIOD_MN1,3,0,MODE_SMA,PRICE_CLOSE,3);
  double Closemn   = iMA(TradePairs[i], PERIOD_MN1,3,0,MODE_SMA,PRICE_CLOSE,0);
             
  if(Openm1 != 0) Signalm1[i] =(Closem1-Openm1)/Openm1*100;
  if(Openm5 != 0) Signalm5[i] =(Closem5-Openm5)/Openm5*100;      
  if(Openm15 != 0)Signalm15[i]=(Closem15-Openm15)/Openm15*100;      
  if(Openm30 != 0)Signalm30[i]=(Closem30-Openm30)/Openm30*100;      
  if(Openh1 != 0) Signalh1[i] =(Closeh1-Openh1)/Openh1*100;     
  if(Open4 != 0)  Signalh4[i] =(Close4-Open4)/Open4*100;      
  if(Opend1 != 0) Signald1[i] =(Closed1-Opend1)/Opend1*100;      
  if(Openw != 0)  Signalw1[i] =(Closew-Openw)/Openw*100;      
  if(Openmn != 0) Signalmn[i] =(Closemn-Openmn)/Openmn*100; 
  
  double s=0.0;
  int n=1;     
  for(int a=1;a<=20;a++)
  {
  if(PairPip != 0) s=s+(iHigh(TradePairs[i],PERIOD_D1,n)-iLow(TradePairs[i],PERIOD_D1,n))/PairPip;
  if(a==1) adr1[i]=MathRound(s);
  if(a==5) adr5[i]=MathRound(s/5);
  if(a==10) adr10[i]=MathRound(s/10);
  if(a==20) adr20[i]=MathRound(s/20);
  n++; 
  }
  adr[i]=MathRound((adr1[i]+adr5[i]+adr10[i]+adr20[i])/4.0);
  
  double high   = iHigh(TradePairs[i],period1[e],0);
  double low    = iLow(TradePairs[i],period1[e],0);
  double close  = iClose(TradePairs[i],period1[e],0);
  double open   = iOpen(TradePairs[i],period1[e],0);
  
  if (StringFind(TradePairs[i],"USD",0)!=-1) factor=10;
  else factor=1000;// <<<---VERIFICAR SE NAO ESTA ERRADO, STOPANDO EM PIPETES
  
//INTRADAY         
  if(Signalm5[i]>0.0&&Signalm15[i]>0.0&&Signalh1[i]>0.0){SetObjText("SigP"+IntegerToString(i),CharToStr(233),c_axis+400,(i*12)+cc_axis+234,BullColor,6);}
  else if(Signalm5[i]<0.0&&Signalm15[i]<0.0&&Signalh1[i]<0.0){SetObjText("SigP"+IntegerToString(i),CharToStr(234),c_axis+400,(i*12)+cc_axis+234,BearColor,6);}
  else {SetObjText("SigP"+IntegerToString(i),CharToStr(232),c_axis+400,(i*12)+cc_axis+234,Orange,6);}
  if(Signalh4[i]>0.0&&Signald1[i]>0.0&&Signalw1[i]>0.0){SetObjText("SGDID"+IntegerToString(i),CharToStr(233),c_axis+410,(i*12)+cc_axis+234,BullColor,6);}
  else if(Signalh4[i]<0.0&&Signald1[i]<0.0&&Signalw1[i]<0.0){SetObjText("SGDID"+IntegerToString(i),CharToStr(234),c_axis+410,(i*12)+cc_axis+234,BearColor,6);}
  else {SetObjText("SGDID"+IntegerToString(i),CharToStr(232),c_axis+410,(i*12)+cc_axis+234,Orange,6);}
//INTRADAY
  if (Pips[i]>0&&Signalm5[i]>0.0&&Signalm15[i]>0.0&&Signalh1[i]>0.0&&Signalh4[i]>0.0&&Signald1[i]>0.0&&Signalw1[i]>0.0)
  labelcolor = BullColor;
  else if (Pips[i]<0&&Signalm5[i]<0.0&&Signalm15[i]<0.0&&Signalh1[i]<0.0&&Signalh4[i]<0.0&&Signald1[i]<0.0&&Signalw1[i]<0.0)
  labelcolor = BearColor;
  else  labelcolor = BackGrnCol;
//SIGNAL INTRADAY  
  }
  }
  }
//INTRADAY

  for(int j=0; j<28; j++)
  { NewTracePivot(GetAverageRangeHigh(TradePairs[j]),GetAverageRangeLow(TradePairs[j]),j,0,clrAliceBlue); 
  GetCciSignals(j);
  color MyColor;
  if(isUpperLowerBollinger(j)==  1) { MyColor = BullColor; } 
  else if(isUpperLowerBollinger(j)== -1) { MyColor = BearColor; }
  else { MyColor = clrBlack; }       

  ObjectSet("bbTouch"+IntegerToString(j), OBJPROP_COLOR,MyColor); 	// cambio di colore }
  } 
             
  for(int i=0; i<ArraySize(list00); i++)
  for(int a=0;a<1;a++)
  {
  SetColors(i);
     
  ChngBoxCol((signals[i].Signalperc   * 100), i);      
  ChngBoxCol1((signals[i].Signalperc1 * 100), i);          
  ChngBoxCol2((signals[i].Signalperc2 * 100), i);
  ChngBoxCol3((signals[i].Signalperc3 * 100), i);
  ChngBoxCol4((signals[i].Signalperc4 * 100), i);          
  
  SetText("Percent"+IntegerToString(i),DoubleToStr(signals[i].Signalperc,2)+"%" ,(i*47)+x_axis+13,y_axis+612,clrBlack,6);
  SetText("Percnt2"+IntegerToString(i),DoubleToStr(signals[i].Signalperc1,2)+"%" ,(i*47)+x_axis+13,y_axis+624,clrBlack,6);
  SetText("Percent3"+IntegerToString(i),DoubleToStr(signals[i].Signalperc2,2)+"%" ,(i*47)+x_axis+13,y_axis+636,clrBlack,6);
  SetText("Percent4"+IntegerToString(i),DoubleToStr(signals[i].Signalperc3,2)+"%" ,(i*47)+x_axis+13,y_axis+648,clrBlack,6);
  SetText("Percent5"+IntegerToString(i),DoubleToStr(signals[i].Signalperc4,2)+"%" ,(i*47)+x_axis+13,y_axis+660,clrBlack,6);   

  if(MathAbs(signals[i].Signalusd)>MathAbs(signals[i].prevSignalusd)){SetObjText("SD"+IntegerToString(i),CharToStr(216),(i*47)+x_axis+25,y_axis+675,BullColor,6);}
  if(MathAbs(signals[i].Signalusd)<MathAbs(signals[i].prevSignalusd)){SetObjText("SD"+IntegerToString(i),CharToStr(215),(i*47)+x_axis+25,y_axis+675,BearColor,6);}
  if(signals[i].Signalusd==signals[i].prevSignalusd){SetObjText("SD"+IntegerToString(i),"",(i*47)+x_axis+5,y_axis+680,clrGray,6);}
  ObjectSetText("usdintsig"+IntegerToString(i),DoubleToStr(MathAbs( signals[i].Signalusd),0)+"%",6,NULL,Color9);
      

//BOTAO LOTES
ObjectSetText("LotSize","Lot:           "+DoubleToString(lot,2));
//BOTAO LOTES
//BOTAO STOPS
ObjectSetText("Piptp","PipTP:       "+DoubleToString(Piptp,2));
ObjectSetText("Pipsl","PipSL:       "+DoubleToString(Pipsl,2));
//---
ObjectSetText("Adr1tp","AdrTP: % "+DoubleToString(Adr1tp,2));
ObjectSetText("Adr1sl","AdrSL: % "+DoubleToString(Adr1sl,2));
//BOTAO STOPS
//HI-LO / ASK-BID
//  SetText("pointrange"+IntegerToString(i),DoubleToStr(signals[i].range3,0),x_axis+740,(i*12)+y_axis+234,clrGray,7); 
//  SetText("high"+IntegerToString(i),DoubleToStr(signals[i].high3,signals[i].digit3),x_axis+765,(i*12)+y_axis+234,clrGreen,7);
//  SetText("ask"+IntegerToString(i),DoubleToStr(signals[i].ask3,signals[i].digit3),x_axis+805,(i*12)+y_axis+234,clrLime,7); 
//  SetText("bid"+IntegerToString(i),DoubleToStr(signals[i].bid3,signals[i].digit3),x_axis+845,(i*12)+y_axis+234,clrTomato,7); 
//  SetText("low"+IntegerToString(i),DoubleToStr(signals[i].low3,signals[i].digit3),x_axis+885,(i*12)+y_axis+234,clrRed,7); 
//HI-LO / ASK-BID
//  if(pairinfo[i].PipsSig==UP){SetObjText("Sigpips"+IntegerToString(i),CharToStr(217),c_axis+262,(i*12)+cc_axis+234,BullColor,6);
//  }
//  else if(pairinfo[i].PipsSig==DOWN){SetObjText("Sigpips"+IntegerToString(i),CharToStr(218),c_axis+262,(i*12)+cc_axis+234,BearColor,6);
//  }
  
  //if(signals[i].Signalcci==UP){SetObjText("CCI"+IntegerToString(i),CharToStr(225),x_axis+480,(i*12)+y_axis+235,BullColor,8);
  //}
  //if(signals[i].Signalcci==DOWN){SetObjText("CCI"+IntegerToString(i),CharToStr(226),x_axis+480,(i*12)+y_axis+235,BearColor,8);
  //}
  

/*//CCI
  if(signals[i].Signalcciup1==UP){SetObjText("CCIup1"+IntegerToString(i),CharToStr(241),b_axis+460,(i*12)+bb_axis+234,BullColor,7);}//02 CCI M30
  if(signals[i].Signalccidn1==DOWN){SetObjText("CCIdn1"+IntegerToString(i),CharToStr(242),b_axis+460,(i*12)+bb_axis+234,BearColor,7);}//02 CCI M30
  if(signals[i].Signalcciup2==UP){SetObjText("CCIup2"+IntegerToString(i),CharToStr(241),b_axis+470,(i*12)+bb_axis+234,BullColor,7);}//02 CCI H1
  if(signals[i].Signalccidn2==DOWN){SetObjText("CCIdn2"+IntegerToString(i),CharToStr(242),b_axis+470,(i*12)+bb_axis+234,BearColor,7);}//02 CCI H1
  if(signals[i].Signalcciup3==UP){SetObjText("CCIup3"+IntegerToString(i),CharToStr(241),b_axis+480,(i*12)+bb_axis+234,BullColor,7);}//02 CCI H4
  if(signals[i].Signalccidn3==DOWN){SetObjText("CCIdn3"+IntegerToString(i),CharToStr(242),b_axis+480,(i*12)+bb_axis+234,BearColor,7);}//02 CCI H4
//RSI
  if(signals[i].Signalrsiup1==UP){SetObjText("RSIup1"+IntegerToString(i),CharToStr(241),b_axis+490,(i*12)+bb_axis+234,BullColor,7);}//01 RSI  M30
  if(signals[i].Signalrsidn1==DOWN){SetObjText("RSIdn1"+IntegerToString(i),CharToStr(242),b_axis+490,(i*12)+bb_axis+234,BearColor,7);}//01 RSI  M30 
  if(signals[i].Signalrsiup2==UP){SetObjText("RSIup2"+IntegerToString(i),CharToStr(241),b_axis+500,(i*12)+bb_axis+234,BullColor,7);}//01 RSI  H1
  if(signals[i].Signalrsidn2==DOWN){SetObjText("RSIdn2"+IntegerToString(i),CharToStr(242),b_axis+500,(i*12)+bb_axis+234,BearColor,7);}//01 RSI  H1
  if(signals[i].Signalrsiup3==UP){SetObjText("RSIup3"+IntegerToString(i),CharToStr(241),b_axis+510,(i*12)+bb_axis+234,BullColor,7);}//01 RSI  H4
  if(signals[i].Signalrsidn3==DOWN){SetObjText("RSIdn3"+IntegerToString(i),CharToStr(241),b_axis+510,(i*12)+bb_axis+234,BearColor,7);}//01 RSI  H4
//MACD  
  if(signals[i].SignalMACDup01==UP){SetObjText("MACDup1"+IntegerToString(i),CharToStr(241),b_axis+520,(i*12)+bb_axis+234,BullColor,7);}//MACD M30
  if(signals[i].SignalMACDdn01==DOWN){SetObjText("MACDdn1"+IntegerToString(i),CharToStr(242),b_axis+520,(i*12)+bb_axis+234,BearColor,7);}//MACD M30
  if(signals[i].SignalMACDup02==UP){SetObjText("MACDup2"+IntegerToString(i),CharToStr(241),b_axis+530,(i*12)+bb_axis+234,BullColor,7);}//MACD H1
  if(signals[i].SignalMACDdn02==DOWN){SetObjText("MACDdn2"+IntegerToString(i),CharToStr(242),b_axis+530,(i*12)+bb_axis+234,BearColor,7);}//MACD H1  
  if(signals[i].SignalMACDup03==UP){SetObjText("MACDup3"+IntegerToString(i),CharToStr(241),b_axis+540,(i*12)+bb_axis+234,BullColor,7);}//MACD H4
  if(signals[i].SignalMACDdn03==DOWN){SetObjText("MACDdn3"+IntegerToString(i),CharToStr(242),b_axis+540,(i*12)+bb_axis+234,BearColor,7);}//MACD H4*/       
//CANDLE DIRECTION  
  if(signals[i].SignalCDm1==UP){SetObjText("CDM1"+IntegerToString(i),CharToStr(127),(i*47)+c_axis-644,cc_axis+689,BullColor,8);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDm1==DOWN){SetObjText("CDM1"+IntegerToString(i),CharToStr(127),(i*47)+c_axis-644,cc_axis+689,BearColor,8);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDm5==UP){SetObjText("CDM5"+IntegerToString(i),CharToStr(127),(i*47)+c_axis-639,cc_axis+689,BullColor,8);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDm5==DOWN){SetObjText("CDM5"+IntegerToString(i),CharToStr(127),(i*47)+c_axis-639,cc_axis+689,BearColor,8);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDm15==UP){SetObjText("CDM15"+IntegerToString(i),CharToStr(127),(i*47)+c_axis-634,cc_axis+689,BullColor,8);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDm15==DOWN){SetObjText("CDM15"+IntegerToString(i),CharToStr(127),(i*47)+c_axis-634,cc_axis+689,BearColor,8);}//08 CANDLE DIRECTION      
  if(signals[i].SignalCDm30==UP){SetObjText("CDM30"+IntegerToString(i),CharToStr(127),(i*47)+c_axis-629,cc_axis+689,BullColor,8);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDm30==DOWN){SetObjText("CDM30"+IntegerToString(i),CharToStr(127),(i*47)+c_axis-629,cc_axis+689,BearColor,8);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDh1==UP){SetObjText("CDH1"+IntegerToString(i),CharToStr(127),(i*47)+c_axis-624,cc_axis+689,BullColor,8);}//09 CANDLE DIRECTION
  if(signals[i].SignalCDh1==DOWN){SetObjText("CDH1"+IntegerToString(i),CharToStr(127),(i*47)+c_axis-624,cc_axis+689,BearColor,8);}//09 CANDLE DIRECTION
  if(signals[i].SignalCDh4==UP){SetObjText("CDH4"+IntegerToString(i),CharToStr(127),(i*47)+c_axis-619,cc_axis+689,BullColor,8);}//10 CANDLE DIRECTION
  if(signals[i].SignalCDh4==DOWN){SetObjText("CDH4"+IntegerToString(i),CharToStr(127),(i*47)+c_axis-619,cc_axis+689,BearColor,8);}//10 CANDLE DIRECTION
  if(signals[i].SignalCDd1==UP){SetObjText("CDD1"+IntegerToString(i),CharToStr(127),(i*47)+c_axis-614,cc_axis+689,BullColor,8);}//10 CANDLE DIRECTION
  if(signals[i].SignalCDd1==DOWN){SetObjText("CDD1"+IntegerToString(i),CharToStr(127),(i*47)+c_axis-614,cc_axis+689,BearColor,8);}//10 CANDLE DIRECTION
  //if(signals[i].SignalCDw1==UP){SetObjText("CDW1"+IntegerToString(i),CharToStr(127),c_axis+485,(i*12)+cc_axis+234,BullColor,8);}//10 CANDLE DIRECTION
  //if(signals[i].SignalCDw1==DOWN){SetObjText("CDW1"+IntegerToString(i),CharToStr(127),c_axis+485,(i*12)+cc_axis+234,BearColor,8);}//10 CANDLE DIRECTION
  //if(signals[i].SignalCDmn==UP){SetObjText("CDMN"+IntegerToString(i),CharToStr(127),c_axis+490,(i*12)+cc_axis+234,BullColor,8);}//10 CANDLE DIRECTION
  //if(signals[i].SignalCDmn==DOWN){SetObjText("CDMN"+IntegerToString(i),CharToStr(127),c_axis+490,(i*12)+cc_axis+234,BearColor,8);}//10 CANDLE DIRECTION     
//MEDIAS MOVEIS
/*  if(signals[i].SignalM01up==UP){SetObjText("MM12M15"+IntegerToString(i),CharToStr(200),b_axis+565,(i*12)+bb_axis+234,BullColor,6);}//06 MM12 
  if(signals[i].SignalM01up==DOWN){SetObjText("MM12M15"+IntegerToString(i),CharToStr(202),b_axis+565,(i*12)+bb_axis+234,BearColor,6);}//06 MM12 
  if(signals[i].SignalM02dn==UP){SetObjText("MM12M30"+IntegerToString(i),CharToStr(200),b_axis+565,(i*12)+bb_axis+234,BullColor,6);}//06 MM12 
  if(signals[i].SignalM02dn==DOWN){SetObjText("MM12M30"+IntegerToString(i),CharToStr(202),b_axis+565,(i*12)+bb_axis+234,BearColor,6);}//06 MM12
  if(signals[i].SignalM03up==UP){SetObjText("MM12H1"+IntegerToString(i),CharToStr(200),b_axis+573,(i*12)+bb_axis+234,BullColor,6);}//06 MM12 
  if(signals[i].SignalM03up==DOWN){SetObjText("MM12H1"+IntegerToString(i),CharToStr(202),b_axis+573,(i*12)+bb_axis+234,BearColor,6);}//06 MM12 
  if(signals[i].SignalM04dn==UP){SetObjText("MM12H4"+IntegerToString(i),CharToStr(200),b_axis+573,(i*12)+bb_axis+234,BullColor,6);}//06 MM12 
  if(signals[i].SignalM04dn==DOWN){SetObjText("MM12H4"+IntegerToString(i),CharToStr(202),b_axis+573,(i*12)+bb_axis+234,BearColor,6);}//06 MM12 
  if(signals[i].SignalM05up==UP){SetObjText("MM12D1"+IntegerToString(i),CharToStr(236),b_axis+581,(i*12)+bb_axis+234,BullColor,6);}//06 MM12 
  if(signals[i].SignalM05up==DOWN){SetObjText("MM12D1"+IntegerToString(i),CharToStr(238),b_axis+581,(i*12)+bb_axis+234,BearColor,6);}//06 MM12 
  if(signals[i].SignalM06dn==UP){SetObjText("MM12D1"+IntegerToString(i),CharToStr(236),b_axis+581,(i*12)+bb_axis+234,BullColor,6);}//06 MM12 
  if(signals[i].SignalM06dn==DOWN){SetObjText("MM12D1"+IntegerToString(i),CharToStr(238),b_axis+581,(i*12)+bb_axis+234,BearColor,6);}//06 MM12

  if(signals[i].SignalM07up==UP){SetObjText("MM21M15"+IntegerToString(i),CharToStr(200),b_axis+589,(i*12)+bb_axis+234,BullColor,6);}//07 MM21 
  if(signals[i].SignalM07up==DOWN){SetObjText("MM21M15"+IntegerToString(i),CharToStr(202),b_axis+589,(i*12)+bb_axis+234,BearColor,6);}//07 MM21 
  if(signals[i].SignalM08dn==UP){SetObjText("MM21M30"+IntegerToString(i),CharToStr(200),b_axis+589,(i*12)+bb_axis+234,BullColor,6);}//07 MM21 
  if(signals[i].SignalM08dn==DOWN){SetObjText("MM21M30"+IntegerToString(i),CharToStr(202),b_axis+589,(i*12)+bb_axis+234,BearColor,6);}//07 MM21 
  if(signals[i].SignalM09up==UP){SetObjText("MM21H1"+IntegerToString(i),CharToStr(200),b_axis+597,(i*12)+bb_axis+234,BullColor,6);}//07 MM21  
  if(signals[i].SignalM09up==DOWN){SetObjText("MM21H1"+IntegerToString(i),CharToStr(202),b_axis+597,(i*12)+bb_axis+234,BearColor,6);}//07 MM21 
  if(signals[i].SignalM10dn==UP){SetObjText("MM21H4"+IntegerToString(i),CharToStr(200),b_axis+597,(i*12)+bb_axis+234,BullColor,6);}//07 MM21 
  if(signals[i].SignalM10dn==DOWN){SetObjText("MM21H4"+IntegerToString(i),CharToStr(202),b_axis+597,(i*12)+bb_axis+234,BearColor,6);}//07 MM21 
  if(signals[i].SignalM11up==UP){SetObjText("MM21D1"+IntegerToString(i),CharToStr(236),b_axis+605,(i*12)+bb_axis+234,BullColor,6);}//07 MM21 
  if(signals[i].SignalM11up==DOWN){SetObjText("MM21D1"+IntegerToString(i),CharToStr(238),b_axis+605,(i*12)+bb_axis+234,BearColor,6);}//07 MM21  
  if(signals[i].SignalM12dn==UP){SetObjText("MM21D1"+IntegerToString(i),CharToStr(236),b_axis+605,(i*12)+bb_axis+234,BullColor,6);}//07 MM21 
  if(signals[i].SignalM12dn==DOWN){SetObjText("MM21D1"+IntegerToString(i),CharToStr(238),b_axis+605,(i*12)+bb_axis+234,BearColor,6);}//07 MM21  
  
  if(signals[i].SignalM13up==UP){SetObjText("MM30M15"+IntegerToString(i),CharToStr(200),b_axis+613,(i*12)+bb_axis+234,BullColor,6);}//03 MM30 
  if(signals[i].SignalM13up==DOWN){SetObjText("MM30M15"+IntegerToString(i),CharToStr(202),b_axis+613,(i*12)+bb_axis+234,BearColor,6);}//03 MM30 
  if(signals[i].SignalM14dn==UP){SetObjText("MM30M30"+IntegerToString(i),CharToStr(200),b_axis+613,(i*12)+bb_axis+234,BullColor,6);}//03 MM30 
  if(signals[i].SignalM14dn==DOWN){SetObjText("MM30M30"+IntegerToString(i),CharToStr(202),b_axis+613,(i*12)+bb_axis+234,BearColor,6);}//03 MM30 
  if(signals[i].SignalM15up==UP){SetObjText("MM30H1"+IntegerToString(i),CharToStr(200),b_axis+621,(i*12)+bb_axis+234,BullColor,6);}//03 MM30 
  if(signals[i].SignalM15up==DOWN){SetObjText("MM30H1"+IntegerToString(i),CharToStr(202),b_axis+621,(i*12)+bb_axis+234,BearColor,6);}//03 MM30 
  if(signals[i].SignalM16dn==UP){SetObjText("MM30H4"+IntegerToString(i),CharToStr(200),b_axis+621,(i*12)+bb_axis+234,BullColor,6);}//03 MM30 
  if(signals[i].SignalM16dn==DOWN){SetObjText("MM30H4"+IntegerToString(i),CharToStr(202),b_axis+621,(i*12)+bb_axis+234,BearColor,6);}//03 MM30 
  if(signals[i].SignalM17up==UP){SetObjText("MM30D1"+IntegerToString(i),CharToStr(236),b_axis+629,(i*12)+bb_axis+234,BullColor,6);}//03 MM30 
  if(signals[i].SignalM17up==DOWN){SetObjText("MM30D1"+IntegerToString(i),CharToStr(238),b_axis+629,(i*12)+bb_axis+234,BearColor,6);}//03 MM30  
  if(signals[i].SignalM18dn==UP){SetObjText("MM30D1"+IntegerToString(i),CharToStr(236),b_axis+629,(i*12)+bb_axis+234,BullColor,6);}//03 MM30 
  if(signals[i].SignalM18dn==DOWN){SetObjText("MM30D1"+IntegerToString(i),CharToStr(238),b_axis+629,(i*12)+bb_axis+234,BearColor,6);}//03 MM30  
  
  if(signals[i].SignalM19up==UP){SetObjText("MM50M15"+IntegerToString(i),CharToStr(200),b_axis+637,(i*12)+bb_axis+234,BullColor,6);}//04 MM50 
  if(signals[i].SignalM19up==DOWN){SetObjText("MM50M15"+IntegerToString(i),CharToStr(202),b_axis+637,(i*12)+bb_axis+234,BearColor,6);}//04 MM50 
  if(signals[i].SignalM20dn==UP){SetObjText("MM50M30"+IntegerToString(i),CharToStr(200),b_axis+637,(i*12)+bb_axis+234,BullColor,6);}//04 MM50 
  if(signals[i].SignalM20dn==DOWN){SetObjText("MM50M30"+IntegerToString(i),CharToStr(202),b_axis+637,(i*12)+bb_axis+234,BearColor,6);}//04 MM50 
  if(signals[i].SignalM21up==UP){SetObjText("MM50H1"+IntegerToString(i),CharToStr(200),b_axis+645,(i*12)+bb_axis+234,BullColor,6);}//04 MM50 
  if(signals[i].SignalM21up==DOWN){SetObjText("MM50H1"+IntegerToString(i),CharToStr(202),b_axis+645,(i*12)+bb_axis+234,BearColor,6);}//04 MM50  
  if(signals[i].SignalM22dn==UP){SetObjText("MM50H4"+IntegerToString(i),CharToStr(200),b_axis+645,(i*12)+bb_axis+234,BullColor,6);}//04 MM50 
  if(signals[i].SignalM22dn==DOWN){SetObjText("MM50H4"+IntegerToString(i),CharToStr(202),b_axis+645,(i*12)+bb_axis+234,BearColor,6);}//04 MM50  
  if(signals[i].SignalM23up==UP){SetObjText("MM50D1"+IntegerToString(i),CharToStr(236),b_axis+653,(i*12)+bb_axis+234,BullColor,6);}//04 MM50 
  if(signals[i].SignalM23up==DOWN){SetObjText("MM50D1"+IntegerToString(i),CharToStr(238),b_axis+653,(i*12)+bb_axis+234,BearColor,6);}//04 MM50  
  if(signals[i].SignalM24dn==UP){SetObjText("MM50D1"+IntegerToString(i),CharToStr(236),b_axis+653,(i*12)+bb_axis+234,BullColor,6);}//04 MM50 
  if(signals[i].SignalM24dn==DOWN){SetObjText("MM50D1"+IntegerToString(i),CharToStr(238),b_axis+653,(i*12)+bb_axis+234,BearColor,6);}//04 MM50
  
  if(signals[i].SignalM25up==UP){SetObjText("MM100M15"+IntegerToString(i),CharToStr(200),b_axis+661,(i*12)+bb_axis+234,BullColor,6);}//05 MM100 
  if(signals[i].SignalM25up==DOWN){SetObjText("MM100M15"+IntegerToString(i),CharToStr(202),b_axis+661,(i*12)+bb_axis+234,BearColor,6);}//05 MM100 
  if(signals[i].SignalM26dn==UP){SetObjText("MM100M30"+IntegerToString(i),CharToStr(200),b_axis+661,(i*12)+bb_axis+234,BullColor,6);}//05 MM100 
  if(signals[i].SignalM26dn==DOWN){SetObjText("MM100M30"+IntegerToString(i),CharToStr(202),b_axis+661,(i*12)+bb_axis+234,BearColor,6);}//05 MM100 
  if(signals[i].SignalM27up==UP){SetObjText("MM100H1"+IntegerToString(i),CharToStr(200),b_axis+669,(i*12)+bb_axis+234,BullColor,6);}//05 MM100 
  if(signals[i].SignalM27up==DOWN){SetObjText("MM100H1"+IntegerToString(i),CharToStr(202),b_axis+669,(i*12)+bb_axis+234,BearColor,6);}//05 MM100  
  if(signals[i].SignalM28dn==UP){SetObjText("MM100H4"+IntegerToString(i),CharToStr(200),b_axis+669,(i*12)+bb_axis+234,BullColor,6);}//05 MM100 
  if(signals[i].SignalM28dn==DOWN){SetObjText("MM100H4"+IntegerToString(i),CharToStr(202),b_axis+669,(i*12)+bb_axis+234,BearColor,6);}//05 MM100   
  if(signals[i].SignalM29up==UP){SetObjText("MM100D1"+IntegerToString(i),CharToStr(236),b_axis+677,(i*12)+bb_axis+234,BullColor,6);}//05 MM100 
  if(signals[i].SignalM29up==DOWN){SetObjText("MM100D1"+IntegerToString(i),CharToStr(238),b_axis+677,(i*12)+bb_axis+234,BearColor,6);}//05 MM100  
  if(signals[i].SignalM30dn==UP){SetObjText("MM100D1"+IntegerToString(i),CharToStr(236),b_axis+677,(i*12)+bb_axis+234,BullColor,6);}//05 MM100 
  if(signals[i].SignalM30dn==DOWN){SetObjText("MM100D1"+IntegerToString(i),CharToStr(238),b_axis+677,(i*12)+bb_axis+234,BearColor,6);}//05 MM100
*/  
  SetText("Pr100"+IntegerToString(i),list00[i].symbol00,d_axis+5,(i*12)+dd_axis+233,Colorstr1(list00[i].ratio00),6);
  SetText("Pr111"+IntegerToString(i),list11[i].symbol11,d_axis+120,(i*12)+dd_axis+233,Colorstr1(list11[i].ratio11),6);
  SetText("Pr122"+IntegerToString(i),list22[i].symbol22,d_axis+235,(i*12)+dd_axis+233,Colorstr1(list22[i].ratio22),6);
  SetText("Pr133"+IntegerToString(i),list33[i].symbol33,d_axis+350,(i*12)+dd_axis+233,Colorstr1(list33[i].ratio33),6);
  SetText("Pr144"+IntegerToString(i),list44[i].symbol44,d_axis+465,(i*12)+dd_axis+233,Colorstr1(list44[i].ratio44),6);
  SetText("Pr155"+IntegerToString(i),list55[i].symbol55,d_axis+580,(i*12)+dd_axis+233,Colorstr1(list55[i].ratio55),6);
  SetText("Pr166"+IntegerToString(i),list66[i].symbol66,d_axis+695,(i*12)+dd_axis+233,Colorstr1(list66[i].ratio66),6);
  //SetText("Pr1234"+IntegerToString(i),list[i].symbol,(i*47)+x_axis+5,y_axis+610,Colorstr1(list[i].ratio),6);

  SetText("fxs00"+IntegerToString(i),DoubleToStr(MathAbs(list00[i].ratio00),1)+"%",d_axis+45,(i*12)+dd_axis+233,Colorstr1(list00[i].ratio00),6);//---
  SetText("fxs11"+IntegerToString(i),DoubleToStr(MathAbs(list11[i].ratio11),1)+"%",d_axis+160,(i*12)+dd_axis+233,Colorstr1(list11[i].ratio11),6);//---
  SetText("fxs22"+IntegerToString(i),DoubleToStr(MathAbs(list22[i].ratio22),1)+"%",d_axis+275,(i*12)+dd_axis+233,Colorstr1(list22[i].ratio22),6);//---
  SetText("fxs33"+IntegerToString(i),DoubleToStr(MathAbs(list33[i].ratio33),1)+"%",d_axis+390,(i*12)+dd_axis+233,Colorstr1(list33[i].ratio33),6);//---
  SetText("fxs44"+IntegerToString(i),DoubleToStr(MathAbs(list44[i].ratio44),1)+"%",d_axis+505,(i*12)+dd_axis+233,Colorstr1(list44[i].ratio44),6);//---
  SetText("fxs55"+IntegerToString(i),DoubleToStr(MathAbs(list55[i].ratio55),1)+"%",d_axis+620,(i*12)+dd_axis+233,Colorstr1(list55[i].ratio55),6);//---
  SetText("fxs66"+IntegerToString(i),DoubleToStr(MathAbs(list66[i].ratio66),1)+"%",d_axis+735,(i*12)+dd_axis+233,Colorstr1(list66[i].ratio66),6);//---
    
  //SetText("RelStrgth00"+IntegerToString(i),DoubleToStr(list00[i].calc00,0),d_axis+95,(i*12)+dd_axis+233,Colorsync00(list00[i].calc00),6);
  //SetText("RelStrgth11"+IntegerToString(i),DoubleToStr(list11[i].calc11,0),d_axis+210,(i*12)+dd_axis+233,Colorsync11(list11[i].calc11),6);
  //SetText("RelStrgth22"+IntegerToString(i),DoubleToStr(list22[i].calc22,0),d_axis+325,(i*12)+dd_axis+233,Colorsync22(list22[i].calc22),6);
  //SetText("RelStrgth33"+IntegerToString(i),DoubleToStr(list33[i].calc33,0),d_axis+440,(i*12)+dd_axis+233,Colorsync33(list33[i].calc33),6);
  //SetText("RelStrgth44"+IntegerToString(i),DoubleToStr(list44[i].calc44,0),d_axis+555,(i*12)+dd_axis+233,Colorsync44(list44[i].calc44),6);
  //SetText("RelStrgth55"+IntegerToString(i),DoubleToStr(list55[i].calc55,0),d_axis+670,(i*12)+dd_axis+233,Colorsync55(list55[i].calc55),6);
  //SetText("RelStrgth66"+IntegerToString(i),DoubleToStr(list66[i].calc66,0),d_axis+785,(i*12)+dd_axis+233,Colorsync66(list66[i].calc66),6);
  
  SetText("Pips00"+IntegerToString(i),DoubleToStr(MathAbs(list00[i].pips00),0),d_axis+105,(i*12)+dd_axis+233,ColorPips1(list00[i].pips00),6);
  SetText("Pips11"+IntegerToString(i),DoubleToStr(MathAbs(list11[i].pips11),0),d_axis+220,(i*12)+dd_axis+233,ColorPips1(list11[i].pips11),6);
  SetText("Pips22"+IntegerToString(i),DoubleToStr(MathAbs(list22[i].pips22),0),d_axis+335,(i*12)+dd_axis+233,ColorPips1(list22[i].pips22),6);
  SetText("Pips33"+IntegerToString(i),DoubleToStr(MathAbs(list33[i].pips33),0),d_axis+450,(i*12)+dd_axis+233,ColorPips1(list33[i].pips33),6);
  SetText("Pips44"+IntegerToString(i),DoubleToStr(MathAbs(list44[i].pips44),0),d_axis+565,(i*12)+dd_axis+233,ColorPips1(list44[i].pips44),6);
  SetText("Pips55"+IntegerToString(i),DoubleToStr(MathAbs(list55[i].pips55),0),d_axis+680,(i*12)+dd_axis+233,ColorPips1(list55[i].pips55),6);
  SetText("Pips66"+IntegerToString(i),DoubleToStr(MathAbs(list66[i].pips66),0),d_axis+795,(i*12)+dd_axis+233,ColorPips1(list66[i].pips66),6);
  //SetText("Range000"+IntegerToString(i),DoubleToStr(MathAbs(list00[i].range00),0),d_axis+1045,(i*12)+dd_axis+234,ColorPips1(list00[i].range00),6);
  
  SetText("BidRat"+IntegerToString(i),DoubleToStr(signals[i].ratio,1)+"%",c_axis+285,(i*12)+cc_axis+234,Colorstr(signals[i].ratio),6); 
  SetText("BSR"+IntegerToString(i),DoubleToStr(signals[i].strength5,1),c_axis+315,(i*12)+cc_axis+234,ColorBSRat(signals[i].strength5),6);
  SetText("LBS"+IntegerToString(i),DoubleToStr(signals[i].xLBSr,1),c_axis+500,(i*12)+cc_axis+234,ColorBSRat(signals[i].strength5),6);
  SetText("RelStrgth"+IntegerToString(i),DoubleToStr(signals[i].calc,0),c_axis+341,(i*12)+cc_axis+234,Colorsync(signals[i].calc),6);
  SetText("PrevGap"+IntegerToString(i),DoubleToStr(signals[i].strength8,1),c_axis+352,(i*12)+cc_axis+234,clrYellowGreen,6);
  SetText("gap"+signals[i].symbol, DoubleToStr(signals[i].strength_Gap,1),c_axis+372,(i*12)+cc_axis+234,ColorGap(signals[i].strength_Gap),6);
  SetText("rsi"+signals[i].symbol, DoubleToStr(signals[i].RSI,1),c_axis+515,(i*12)+cc_axis+234,ColorRSI(signals[i].RSI),6);
//---  
  if(list00[i].ratio00>0){SetObjText("Sig22"+IntegerToString(i),CharToStr(217),d_axis+70,(i*12)+dd_axis+233,BullColor,6);}
  else if(list00[i].ratio00<0){SetObjText("Sig22"+IntegerToString(i),CharToStr(218),d_axis+70,(i*12)+dd_axis+233,BearColor,6);}
   
  for(int b=0; b<=list00[i].calc00-1; b++)//---
  {
  ObjectDelete("fx1"+IntegerToString(i)+IntegerToString(b));//---  
  
  if(list00[i].ratio00>0){SetText("fx1"+IntegerToString(i)+IntegerToString(b),"|",(b*3)+d_axis+70,(i*12)+dd_axis+233,BullColor,6);}
  else if(list00[i].ratio00<0){SetText("fx1"+IntegerToString(i)+IntegerToString(b),"|",(b*3)+d_axis+70,(i*12)+dd_axis+233,BearColor,6);}
  }
//---
//---  
  if(list11[i].ratio11>0){SetObjText("Sig2211"+IntegerToString(i),CharToStr(217),d_axis+185,(i*12)+dd_axis+233,BullColor,6);}
  else if(list11[i].ratio11<0){SetObjText("Sig2211"+IntegerToString(i),CharToStr(218),d_axis+185,(i*12)+dd_axis+233,BearColor,6);}
   
  for(int b=0; b<=list11[i].calc11-1; b++)//---
  {
  ObjectDelete("fx111"+IntegerToString(i)+IntegerToString(b));//---  
  
  if(list11[i].ratio11>0){SetText("fx111"+IntegerToString(i)+IntegerToString(b),"|",(b*3)+d_axis+185,(i*12)+dd_axis+233,BullColor,6);}
  else if(list11[i].ratio11<0){SetText("fx111"+IntegerToString(i)+IntegerToString(b),"|",(b*3)+d_axis+185,(i*12)+dd_axis+233,BearColor,6);}
  }
//---
//---  
  if(list22[i].ratio22>0){SetObjText("Sig2222"+IntegerToString(i),CharToStr(217),d_axis+300,(i*12)+dd_axis+233,BullColor,6);}
  else if(list22[i].ratio22<0){SetObjText("Sig2222"+IntegerToString(i),CharToStr(218),d_axis+300,(i*12)+dd_axis+233,BearColor,6);}
   
  for(int b=0; b<=list22[i].calc22-1; b++)//---
  {
  ObjectDelete("fx122"+IntegerToString(i)+IntegerToString(b));//---  
  
  if(list22[i].ratio22>0){SetText("fx122"+IntegerToString(i)+IntegerToString(b),"|",(b*3)+d_axis+300,(i*12)+dd_axis+233,BullColor,6);}
  else if(list22[i].ratio22<0){SetText("fx122"+IntegerToString(i)+IntegerToString(b),"|",(b*3)+d_axis+300,(i*12)+dd_axis+233,BearColor,6);}
  }
//---
//---  
  if(list33[i].ratio33>0){SetObjText("Sig2233"+IntegerToString(i),CharToStr(217),d_axis+415,(i*12)+dd_axis+233,BullColor,6);}
  else if(list33[i].ratio33<0){SetObjText("Sig2233"+IntegerToString(i),CharToStr(218),d_axis+415,(i*12)+dd_axis+233,BearColor,6);}
   
  for(int b=0; b<=list33[i].calc33-1; b++)//---
  {
  ObjectDelete("fx133"+IntegerToString(i)+IntegerToString(b));//---  
  
  if(list33[i].ratio33>0){SetText("fx133"+IntegerToString(i)+IntegerToString(b),"|",(b*3)+d_axis+415,(i*12)+dd_axis+233,BullColor,6);}
  else if(list33[i].ratio33<0){SetText("fx133"+IntegerToString(i)+IntegerToString(b),"|",(b*3)+d_axis+415,(i*12)+dd_axis+233,BearColor,6);}
  }
//---
//---  
  if(list44[i].ratio44>0){SetObjText("Sig2244"+IntegerToString(i),CharToStr(217),d_axis+530,(i*12)+dd_axis+233,BullColor,6);}
  else if(list44[i].ratio44<0){SetObjText("Sig2244"+IntegerToString(i),CharToStr(218),d_axis+530,(i*12)+dd_axis+233,BearColor,6);}
   
  for(int b=0; b<=list44[i].calc44-1; b++)//---
  {
  ObjectDelete("fx144"+IntegerToString(i)+IntegerToString(b));//---  
  
  if(list44[i].ratio44>0){SetText("fx144"+IntegerToString(i)+IntegerToString(b),"|",(b*3)+d_axis+530,(i*12)+dd_axis+233,BullColor,6);}
  else if(list44[i].ratio44<0){SetText("fx144"+IntegerToString(i)+IntegerToString(b),"|",(b*3)+d_axis+530,(i*12)+dd_axis+233,BearColor,6);}
  }
//---
//---  
  if(list55[i].ratio55>0){SetObjText("Sig2255"+IntegerToString(i),CharToStr(217),d_axis+645,(i*12)+dd_axis+233,BullColor,6);}
  else if(list55[i].ratio55<0){SetObjText("Sig2255"+IntegerToString(i),CharToStr(218),d_axis+645,(i*12)+dd_axis+233,BearColor,6);}
   
  for(int b=0; b<=list55[i].calc55-1; b++)//---
  {
  ObjectDelete("fx155"+IntegerToString(i)+IntegerToString(b));//---  
  
  if(list55[i].ratio55>0){SetText("fx155"+IntegerToString(i)+IntegerToString(b),"|",(b*3)+d_axis+645,(i*12)+dd_axis+233,BullColor,6);}
  else if(list55[i].ratio55<0){SetText("fx155"+IntegerToString(i)+IntegerToString(b),"|",(b*3)+d_axis+645,(i*12)+dd_axis+233,BearColor,6);}
  }
//---
//---  
  if(list66[i].ratio66>0){SetObjText("Sig2266"+IntegerToString(i),CharToStr(217),d_axis+760,(i*12)+dd_axis+233,BullColor,6);}
  else if(list66[i].ratio66<0){SetObjText("Sig2266"+IntegerToString(i),CharToStr(218),d_axis+760,(i*12)+dd_axis+233,BearColor,6);}
   
  for(int b=0; b<=list66[i].calc66-1; b++)//---
  {
  ObjectDelete("fx166"+IntegerToString(i)+IntegerToString(b));//---  
  
  if(list66[i].ratio66>0){SetText("fx166"+IntegerToString(i)+IntegerToString(b),"|",(b*3)+d_axis+760,(i*12)+dd_axis+233,BullColor,6);}
  else if(list66[i].ratio66<0){SetText("fx166"+IntegerToString(i)+IntegerToString(b),"|",(b*3)+d_axis+760,(i*12)+dd_axis+233,BearColor,6);}
  }
//---  
  if(signals[i].SigRatioPrev==UP){SetObjText("Sig"+IntegerToString(i),CharToStr(217),c_axis+307,(i*12)+cc_axis+234,BullColor,6);}
  else if(signals[i].SigRatioPrev==DOWN){SetObjText("Sig"+IntegerToString(i),CharToStr(218),c_axis+307,(i*12)+cc_axis+234,BearColor,6);}
  else{SetObjText("Sig"+IntegerToString(i),CharToStr(243),c_axis+307,(i*12)+cc_axis+234,clrOrange,6);}
  
  //if(signals[i].SigGapPrev==UP){SetObjText("GapSig"+IntegerToString(i),CharToStr(217),c_axis+391,(i*12)+cc_axis+234,BullColor,6);}
  //else if(signals[i].SigGapPrev==DOWN){SetObjText("GapSig"+IntegerToString(i),CharToStr(218),c_axis+391,(i*12)+cc_axis+234,BearColor,6);}
  //else {SetObjText("GapSig"+IntegerToString(i),CharToStr(251),c_axis+391,(i*12)+cc_axis+234,clrWhite,6);}
  
  if(signals[i].SigGapPrev==UP){SetObjText("GapSign"+IntegerToString(i),CharToStr(233),c_axis+391,(i*12)+cc_axis+234,clrLime,6);
  ColorPanel("GAP123"+IntegerToString(i),clrBlue,C'61,61,61');}
  else if(signals[i].SigGapPrev==DOWN){SetObjText("GapSign"+IntegerToString(i),CharToStr(234),c_axis+391,(i*12)+cc_axis+234,clrFireBrick,6);
  ColorPanel("GAP123"+IntegerToString(i),clrIndianRed,C'61,61,61');}
  else {SetObjText("GapSign"+IntegerToString(i),CharToStr(243),c_axis+391,(i*12)+cc_axis+234,clrOrange,6);
  ColorPanel("GAP123"+IntegerToString(i),clrBlack,C'61,61,61');}
//---
 if(signals[i].Signalrsi==UP){SetObjText("RSI_Sig"+IntegerToString(i),CharToStr(233),c_axis+530,(i*12)+cc_axis+234,clrLime,6);}
 else if(signals[i].Signalrsi==DOWN){SetObjText("RSI_Sig"+IntegerToString(i),CharToStr(234),c_axis+530,(i*12)+cc_axis+234,clrFireBrick,6);}
 else {SetObjText("RSI_Sig"+IntegerToString(i),CharToStr(243),c_axis+530,(i*12)+cc_axis+234,clrOrange,6);}  
//---------------------------------------------------------------------------------------------------------------------------+                
  if (((pairinfo[i].PipsSig==UP && pairinfo[i].Pips >trade_MIN_pips) || trigger_use_Pips==false)
  && ((pairinfo[i].Pips >trade_MIN_pips)|| trigger_use_Pips==false)
  && ((pairinfo[i].Pips <trade_MAX_pips)|| trigger_use_Pips==false)
  
  && (signals[i].Signalusd > trade_MIN_Strength || trigger_use_Strength==false) 
    
  && ((signals[i].SigRatioPrev==UP && signals[i].ratio>=trigger_buy_bidratio) || trigger_use_bidratio==false)
  && ((signals[i].ratio > trade_MIN_buy_bidratio)|| trigger_use_bidratio==false)
  && ((signals[i].ratio < trade_MAX_buy_bidratio)|| trigger_use_bidratio==false)
   
  && (list00[i].ratio00>=trigger_buy_bidratio00 || trigger_use_bidratio00==false)
  && ((list00[i].ratio00 > trade_MIN_buy_bidratio00)|| trigger_use_bidratio00==false)
  && ((list00[i].ratio00 < trade_MAX_buy_bidratio00)|| trigger_use_bidratio00==false)  

  && (list11[i].ratio11>=trigger_buy_bidratio11 || trigger_use_bidratio11==false)
  && ((list11[i].ratio11 > trade_MIN_buy_bidratio11)|| trigger_use_bidratio11==false)
  && ((list11[i].ratio11 < trade_MAX_buy_bidratio11)|| trigger_use_bidratio11==false)
  
  && (list22[i].ratio22>=trigger_buy_bidratio22 || trigger_use_bidratio22==false)
  && ((list22[i].ratio22 > trade_MIN_buy_bidratio22)|| trigger_use_bidratio22==false)
  && ((list22[i].ratio22 < trade_MAX_buy_bidratio22)|| trigger_use_bidratio22==false)
  
  && (list33[i].ratio33>=trigger_buy_bidratio33 || trigger_use_bidratio33==false)
  && ((list33[i].ratio33 > trade_MIN_buy_bidratio33)|| trigger_use_bidratio33==false)
  && ((list33[i].ratio33 < trade_MAX_buy_bidratio33)|| trigger_use_bidratio33==false)
  
  && (list44[i].ratio44>=trigger_buy_bidratio44 || trigger_use_bidratio44==false)
  && ((list44[i].ratio44 > trade_MIN_buy_bidratio44)|| trigger_use_bidratio44==false)
  && ((list44[i].ratio44 < trade_MAX_buy_bidratio44)|| trigger_use_bidratio44==false)
  
  && (list55[i].ratio55>=trigger_buy_bidratio55 || trigger_use_bidratio55==false)
  && ((list55[i].ratio55 > trade_MIN_buy_bidratio55)|| trigger_use_bidratio55==false)
  && ((list55[i].ratio55 < trade_MAX_buy_bidratio55)|| trigger_use_bidratio55==false)
  
  && (list66[i].ratio66>=trigger_buy_bidratio66 || trigger_use_bidratio66==false)
  && ((list66[i].ratio66 > trade_MIN_buy_bidratio66)|| trigger_use_bidratio66==false)
  && ((list66[i].ratio66 < trade_MAX_buy_bidratio66)|| trigger_use_bidratio66==false)
  
  && (signals[i].calc>=trigger_buy_relstrength || trigger_use_relstrength==false)
  && ((signals[i].calc > trade_MIN_buy_relstrength)|| trigger_use_relstrength==false)
  && ((signals[i].calc < trade_MAX_buy_relstrength)|| trigger_use_relstrength==false)
  
  && (list00[i].calc00>=trigger_buy_relstrength00 || trigger_use_relstrength00==false)
  && ((list00[i].calc00 > trade_MIN_buy_relstrength00)|| trigger_use_relstrength00==false)
  && ((list00[i].calc00 < trade_MAX_buy_relstrength00)|| trigger_use_relstrength00==false)
  
  && (list11[i].calc11>=trigger_buy_relstrength11 || trigger_use_relstrength11==false)
  && ((list11[i].calc11 > trade_MIN_buy_relstrength11)|| trigger_use_relstrength11==false)
  && ((list11[i].calc11 < trade_MAX_buy_relstrength11)|| trigger_use_relstrength11==false)
  
  && (list22[i].calc22>=trigger_buy_relstrength22 || trigger_use_relstrength22==false)
  && ((list22[i].calc22 > trade_MIN_buy_relstrength22)|| trigger_use_relstrength22==false)
  && ((list22[i].calc22 < trade_MAX_buy_relstrength22)|| trigger_use_relstrength22==false)
  
  && (list33[i].calc33>=trigger_buy_relstrength33 || trigger_use_relstrength33==false)
  && ((list33[i].calc33 > trade_MIN_buy_relstrength33)|| trigger_use_relstrength33==false)
  && ((list33[i].calc33 < trade_MAX_buy_relstrength33)|| trigger_use_relstrength33==false)
  
  && (list44[i].calc44>=trigger_buy_relstrength44 || trigger_use_relstrength44==false)
  && ((list44[i].calc44 > trade_MIN_buy_relstrength44)|| trigger_use_relstrength44==false)
  && ((list44[i].calc44 < trade_MAX_buy_relstrength44)|| trigger_use_relstrength44==false)
  
  && (list55[i].calc55>=trigger_buy_relstrength55 || trigger_use_relstrength55==false)
  && ((list55[i].calc55 > trade_MIN_buy_relstrength55)|| trigger_use_relstrength55==false)
  && ((list55[i].calc55 < trade_MAX_buy_relstrength55)|| trigger_use_relstrength55==false)
  
  && (list66[i].calc66>=trigger_buy_relstrength66 || trigger_use_relstrength66==false)
  && ((list66[i].calc66 > trade_MIN_buy_relstrength66)|| trigger_use_relstrength66==false)
  && ((list66[i].calc66 < trade_MAX_buy_relstrength66)|| trigger_use_relstrength66==false)  
//PIPS
  && (list00[i].pips00>=trigger_buy_pips00 || trigger_use_pips00==false)
 
  && (list11[i].pips11>=trigger_buy_pips11 || trigger_use_pips11==false)
  
  && (list22[i].pips22>=trigger_buy_pips22 || trigger_use_pips22==false)
  
  && (list33[i].pips33>=trigger_buy_pips33 || trigger_use_pips33==false)
  
  && (list44[i].pips44>=trigger_buy_pips44 || trigger_use_pips44==false)
  
  && (list55[i].pips55>=trigger_buy_pips55 || trigger_use_pips55==false)
  
  && (list66[i].pips66>=trigger_buy_pips66 || trigger_use_pips66==false)
//PIPS
    
  && (signals[i].strength5>=trigger_buy_buysellratio || trigger_use_buysellratio==false)
  && ((signals[i].strength5 > trade_MIN_buy_buysellratio)|| trigger_use_buysellratio==false)
  && ((signals[i].strength5 < trade_MAX_buy_buysellratio)|| trigger_use_buysellratio==false)
  
  && ((signals[i].SigGapPrev==UP && signals[i].strength_Gap>=trigger_gap_buy) || trigger_use_gap==false)         
  && ((signals[i].strength_Gap > trade_MIN_gap_buy)|| trigger_use_gap==false)
  && ((signals[i].strength_Gap < trade_MAX_gap_buy)|| trigger_use_gap==false)      
    
  && (signals[i].Signalperc >trade_MIN_HeatMap1 || trigger_UseHeatMap1==false)
  && (signals[i].Signalperc1 >trade_MIN_HeatMap2 || trigger_UseHeatMap2==false)
  && (signals[i].Signalperc2 >trade_MIN_HeatMap3 || trigger_UseHeatMap3==false)
  && (signals[i].Signalperc3 >trade_MIN_HeatMap4 || trigger_UseHeatMap4==false)
  && (signals[i].Signalperc4 >trade_MIN_HeatMap5 || trigger_UseHeatMap5==false)

  && (signals[i].upperBand>0||UseBb==false )
  
  && (signals[i].SignalM01up>0||trigger_Moving_Average1==false )
  && (signals[i].SignalM03up>0||trigger_Moving_Average2==false )
  && (signals[i].SignalM05up>0||trigger_Moving_Average3==false )

  && (signals[i].SignalM07up>0||trigger_Moving_Average4==false )
  && (signals[i].SignalM09up>0||trigger_Moving_Average5==false )
  && (signals[i].SignalM11up>0||trigger_Moving_Average6==false )

  && (signals[i].SignalM13up>0||trigger_Moving_Average7==false )
  && (signals[i].SignalM15up>0||trigger_Moving_Average8==false )
  && (signals[i].SignalM17up>0||trigger_Moving_Average9==false )

  && (signals[i].SignalM19up>0||trigger_Moving_Average10==false )
  && (signals[i].SignalM21up>0||trigger_Moving_Average11==false )
  && (signals[i].SignalM23up>0||trigger_Moving_Average12==false )

  && (signals[i].SignalM25up>0||trigger_Moving_Average13==false )
  && (signals[i].SignalM27up>0||trigger_Moving_Average14==false )
  && (signals[i].SignalM29up>0||trigger_Moving_Average15==false )
  
  && (signals[i].Signaldirup>0||trigger_Candle_Direction==false)

  && (signals[i].Signalcci >= UP || UseCCI==false)
  && (signals[i].Signalcciup1 >= UP || UseCCI1==false)
  && (signals[i].Signalcciup2 >= UP || UseCCI2==false)
  && (signals[i].Signalcciup3 >= UP || UseCCI3==false)
  && (signals[i].Signalrsi==UP || trigger_use_RSI==false)
  && (signals[i].Signalrsiup1 >= UP || UseRSI1==false)
  && (signals[i].Signalrsiup2 >= UP || UseRSI2==false)
  && (signals[i].Signalrsiup3 >= UP || UseRSI3==false)
  && (signals[i].SignalMACDup01 >= UP || trigger_MACD1==false)
  && (signals[i].SignalMACDup02 >= UP || trigger_MACD2==false)
  && (signals[i].SignalMACDup03 >= UP || trigger_MACD3==false))      
  
  {
  labelcolor = clrGreen;
  if ((bpos[i]+spos[i]) < MaxTrades && pairinfo[i].lastSignal != BUY && autotrade == true && (OnlyAddProfit == false || bprofit[i] >= 0.0) && pairinfo[i].Spread <= MaxSpread && inSession() == true && totaltrades <= maxtotaltrades) {
  pairinfo[i].lastSignal = BUY;
   
  while (IsTradeContextBusy()) Sleep(100);
  ticket=OrderSend(TradePairs[i],OP_BUY,lot,MarketInfo(TradePairs[i],MODE_ASK),100,0,0,comment,Magic_Number,0,Blue);
  if (OrderSelect(ticket,SELECT_BY_TICKET) == true) {
  if (Pipsl != 0.0)
  stoploss=OrderOpenPrice() - Pipsl * pairinfo[i].PairPip;
  else
  if (Adr1sl != 0.0)
  stoploss=OrderOpenPrice() - ((adrvalues[i].adr10/100)*Adr1sl) * pairinfo[i].PairPip;
  else
  stoploss = 0.0;
   
  if (Piptp != 0.0)
  takeprofit=OrderOpenPrice() + Piptp * pairinfo[i].PairPip;
  else
  if (Adr1tp != 0.0)
  takeprofit=OrderOpenPrice() + ((adrvalues[i].adr10/100)*Adr1tp) * pairinfo[i].PairPip;
  else
  takeprofit = 0.0;
   
  while (IsTradeContextBusy()) Sleep(100);
  OrderModify(ticket,OrderOpenPrice(),NormalizeDouble(stoploss,MarketInfo(TradePairs[i],MODE_DIGITS)),NormalizeDouble(takeprofit,MarketInfo(TradePairs[i],MODE_DIGITS)),0,clrBlue);
  }
  }
  }
  else
  {
  if (((pairinfo[i].PipsSig==DOWN && pairinfo[i].Pips < - trade_MIN_pips) || trigger_use_Pips==false)
  && ((pairinfo[i].Pips < - trade_MIN_pips)|| trigger_use_Pips==false) 
  && ((pairinfo[i].Pips > - trade_MAX_pips) || trigger_use_Pips==false)
  
  && (signals[i].Signalusd < - trade_MIN_Strength || trigger_use_Strength==false)
  
  && ((signals[i].SigRatioPrev==DOWN && signals[i].ratio<=trigger_sell_bidratio) || trigger_use_bidratio==false)
  && ((signals[i].ratio < trade_MIN_sell_bidratio)|| trigger_use_bidratio==false)
  && ((signals[i].ratio > trade_MAX_sell_bidratio)|| trigger_use_bidratio==false)
  
  && (list00[i].ratio00<=trigger_sell_bidratio00 || trigger_use_bidratio00==false)
  && ((list00[i].ratio00 < trade_MIN_sell_bidratio00)|| trigger_use_bidratio00==false)
  && ((list00[i].ratio00 > trade_MAX_sell_bidratio00)|| trigger_use_bidratio00==false)
  
  && (list11[i].ratio11<=trigger_sell_bidratio11 || trigger_use_bidratio11==false)
  && ((list11[i].ratio11 < trade_MIN_sell_bidratio11)|| trigger_use_bidratio11==false)
  && ((list11[i].ratio11 > trade_MAX_sell_bidratio11)|| trigger_use_bidratio11==false) 
  
  && (list22[i].ratio22<=trigger_sell_bidratio22 || trigger_use_bidratio22==false)
  && ((list22[i].ratio22 < trade_MIN_sell_bidratio22)|| trigger_use_bidratio22==false)
  && ((list22[i].ratio22 > trade_MAX_sell_bidratio22)|| trigger_use_bidratio22==false)
  
  && (list33[i].ratio33<=trigger_sell_bidratio33 || trigger_use_bidratio33==false)
  && ((list33[i].ratio33 < trade_MIN_sell_bidratio33)|| trigger_use_bidratio33==false)
  && ((list33[i].ratio33 > trade_MAX_sell_bidratio33)|| trigger_use_bidratio33==false)
  
  && (list44[i].ratio44<=trigger_sell_bidratio44 || trigger_use_bidratio44==false)
  && ((list44[i].ratio44 < trade_MIN_sell_bidratio44)|| trigger_use_bidratio44==false)
  && ((list44[i].ratio44 > trade_MAX_sell_bidratio44)|| trigger_use_bidratio44==false) 
  
  && (list55[i].ratio55<=trigger_sell_bidratio55 || trigger_use_bidratio55==false)
  && ((list55[i].ratio55 < trade_MIN_sell_bidratio55)|| trigger_use_bidratio55==false)
  && ((list55[i].ratio55 > trade_MAX_sell_bidratio55)|| trigger_use_bidratio55==false)
  
  && (list66[i].ratio66<=trigger_sell_bidratio66 || trigger_use_bidratio66==false)
  && ((list66[i].ratio66 < trade_MIN_sell_bidratio66)|| trigger_use_bidratio66==false)
  && ((list66[i].ratio66 > trade_MAX_sell_bidratio66)|| trigger_use_bidratio66==false)   
    
  && (signals[i].calc<=trigger_sell_relstrength || trigger_use_relstrength==false)
  && ((signals[i].calc < trade_MIN_sell_relstrength)|| trigger_use_relstrength==false)
  && ((signals[i].calc > trade_MAX_sell_relstrength)|| trigger_use_relstrength==false)

  && (list00[i].calc00<=trigger_sell_relstrength00 || trigger_use_relstrength00==false)
  && ((list00[i].calc00 < trade_MIN_sell_relstrength00)|| trigger_use_relstrength00==false)
  && ((list00[i].calc00 > trade_MAX_sell_relstrength00)|| trigger_use_relstrength00==false)
  
  && (list11[i].calc11<=trigger_sell_relstrength11 || trigger_use_relstrength11==false)
  && ((list11[i].calc11 < trade_MIN_sell_relstrength11)|| trigger_use_relstrength11==false)
  && ((list11[i].calc11 > trade_MAX_sell_relstrength11)|| trigger_use_relstrength11==false)
  
  && (list22[i].calc22<=trigger_sell_relstrength22 || trigger_use_relstrength22==false)
  && ((list22[i].calc22 < trade_MIN_sell_relstrength22)|| trigger_use_relstrength22==false)
  && ((list22[i].calc22 > trade_MAX_sell_relstrength22)|| trigger_use_relstrength22==false)
  
  && (list33[i].calc33<=trigger_sell_relstrength33 || trigger_use_relstrength33==false)
  && ((list33[i].calc33 < trade_MIN_sell_relstrength33)|| trigger_use_relstrength33==false)
  && ((list33[i].calc33 > trade_MAX_sell_relstrength33)|| trigger_use_relstrength33==false)
  
  && (list44[i].calc44<=trigger_sell_relstrength44 || trigger_use_relstrength44==false)
  && ((list44[i].calc44 < trade_MIN_sell_relstrength44)|| trigger_use_relstrength44==false)
  && ((list44[i].calc44 > trade_MAX_sell_relstrength44)|| trigger_use_relstrength44==false)
  
  && (list55[i].calc55<=trigger_sell_relstrength55 || trigger_use_relstrength55==false)
  && ((list55[i].calc55 < trade_MIN_sell_relstrength55)|| trigger_use_relstrength55==false)
  && ((list55[i].calc55 > trade_MAX_sell_relstrength55)|| trigger_use_relstrength55==false)
  
  && (list66[i].calc66<=trigger_sell_relstrength66 || trigger_use_relstrength66==false)
  && ((list66[i].calc66 < trade_MIN_sell_relstrength66)|| trigger_use_relstrength66==false)
  && ((list66[i].calc66 > trade_MAX_sell_relstrength66)|| trigger_use_relstrength66==false)
//PIPS
  && (list00[i].pips00<=trigger_sell_pips00 || trigger_use_pips00==false)
 
  && (list11[i].pips11<=trigger_sell_pips11 || trigger_use_pips11==false)
  
  && (list22[i].pips22<=trigger_sell_pips22 || trigger_use_pips22==false)
  
  && (list33[i].pips33<=trigger_sell_pips33 || trigger_use_pips33==false)
  
  && (list44[i].pips44<=trigger_sell_pips44 || trigger_use_pips44==false)
  
  && (list55[i].pips55<=trigger_sell_pips55 || trigger_use_pips55==false)
  
  && (list66[i].pips66<=trigger_sell_pips66 || trigger_use_pips66==false)
//PIPS    
  && (signals[i].strength5<=trigger_sell_buysellratio || trigger_use_buysellratio==false)
  && ((signals[i].strength5 < trade_MIN_sell_buysellratio)|| trigger_use_buysellratio==false)
  && ((signals[i].strength5 > trade_MAX_sell_buysellratio)|| trigger_use_buysellratio==false)
  
  && ((signals[i].SigGapPrev==DOWN && signals[i].strength_Gap<=trigger_gap_sell) || trigger_use_gap==false)         
  && ((signals[i].strength_Gap < trade_MIN_gap_sell)|| trigger_use_gap==false)
  && ((signals[i].strength_Gap > trade_MAX_gap_sell)|| trigger_use_gap==false)  
  
  && (signals[i].Signalperc <-trade_MIN_HeatMap1 || trigger_UseHeatMap1==false)
  && (signals[i].Signalperc1 <-trade_MIN_HeatMap2 || trigger_UseHeatMap2==false)
  && (signals[i].Signalperc2 <-trade_MIN_HeatMap3 || trigger_UseHeatMap3==false)
  && (signals[i].Signalperc3 <-trade_MIN_HeatMap4 || trigger_UseHeatMap4==false)
  && (signals[i].Signalperc4 <-trade_MIN_HeatMap5 || trigger_UseHeatMap5==false)
  
  && (signals[i].lowerBand>0||UseBb==false )
  
  && (signals[i].SignalM02dn<0||trigger_Moving_Average1==false )
  && (signals[i].SignalM04dn<0||trigger_Moving_Average2==false )
  && (signals[i].SignalM06dn<0||trigger_Moving_Average3==false )

  && (signals[i].SignalM08dn<0||trigger_Moving_Average4==false )
  && (signals[i].SignalM10dn<0||trigger_Moving_Average5==false )
  && (signals[i].SignalM12dn<0||trigger_Moving_Average6==false )

  && (signals[i].SignalM14dn<0||trigger_Moving_Average7==false )
  && (signals[i].SignalM16dn<0||trigger_Moving_Average8==false )
  && (signals[i].SignalM18dn<0||trigger_Moving_Average9==false )

  && (signals[i].SignalM20dn<0||trigger_Moving_Average10==false )
  && (signals[i].SignalM22dn<0||trigger_Moving_Average11==false )
  && (signals[i].SignalM24dn<0||trigger_Moving_Average12==false )

  && (signals[i].SignalM26dn<0||trigger_Moving_Average13==false )
  && (signals[i].SignalM28dn<0||trigger_Moving_Average14==false )
  && (signals[i].SignalM30dn<0||trigger_Moving_Average15==false )
  
  && (signals[i].Signaldirdn>0||trigger_Candle_Direction==false)

  && (signals[i].Signalcci <= DOWN || UseCCI==false)
  && (signals[i].Signalccidn1 <= DOWN || UseCCI1==false)
  && (signals[i].Signalccidn2 <= DOWN || UseCCI2==false)
  && (signals[i].Signalccidn3 <= DOWN || UseCCI3==false)
  && (signals[i].Signalrsi==DOWN  || trigger_use_RSI==false)
  && (signals[i].Signalrsidn1 <= DOWN || UseRSI1==false)
  && (signals[i].Signalrsidn2 <= DOWN || UseRSI2==false)
  && (signals[i].Signalrsidn3 <= DOWN || UseRSI3==false)
  && (signals[i].SignalMACDdn01 <= DOWN || trigger_MACD1==false)
  && (signals[i].SignalMACDdn02 <= DOWN || trigger_MACD1==false)
  && (signals[i].SignalMACDdn03 <= DOWN || trigger_MACD2==false))        
  {
  labelcolor = clrTomato;           
  if ((bpos[i]+spos[i]) < MaxTrades && pairinfo[i].lastSignal != SELL && autotrade == true && (OnlyAddProfit == false || sprofit[i] >= 0.0) && pairinfo[i].Spread <= MaxSpread && inSession() == true && totaltrades <= maxtotaltrades) {
  pairinfo[i].lastSignal = SELL;
  
  while (IsTradeContextBusy()) Sleep(100);
  ticket=OrderSend(TradePairs[i],OP_SELL,lot,MarketInfo(TradePairs[i],MODE_BID),100,0,0,comment,Magic_Number,0,Red);
  if (OrderSelect(ticket,SELECT_BY_TICKET) == true) {
  if (Pipsl != 0.0)
  stoploss=OrderOpenPrice() + Pipsl * pairinfo[i].PairPip;
  else
  if (Adr1sl != 0.0)
  stoploss=OrderOpenPrice()+((adrvalues[i].adr10/100)*Adr1sl)  *pairinfo[i].PairPip;
  else
  stoploss = 0.0;
  
  
  if (Piptp != 0.0)
  takeprofit=OrderOpenPrice() - Piptp * pairinfo[i].PairPip;
  else 
  if (Adr1tp != 0.0)
  takeprofit=OrderOpenPrice() - ((adrvalues[i].adr10/100)*Adr1tp) * pairinfo[i].PairPip;
  else
  takeprofit = 0.0;
  
  while (IsTradeContextBusy()) Sleep(100);
  OrderModify(ticket,OrderOpenPrice(),NormalizeDouble(stoploss,MarketInfo(TradePairs[i],MODE_DIGITS)),NormalizeDouble(takeprofit,MarketInfo(TradePairs[i],MODE_DIGITS)),0,clrBlue);
  }
  }
  } 
  else
  {
  labelcolor = BackGrnCol;
  pairinfo[i].lastSignal = NOTHING;
  }  
  }
  string HM0 = iCustom(NULL, 0, "HeatMapModokiV1",5, 20, "Arial", 585 , 250, 0 , 0,i);
  string HM1 = iCustom(NULL, 0, "HeatMapModokiV1",15, 20, "Arial", 620 , 250, 0 , 0,i);
  string HM2 = iCustom(NULL, 0, "HeatMapModokiV1",30, 20, "Arial", 655 , 250, 0 , 0,i);
  string HM3 = iCustom(NULL, 0, "HeatMapModokiV1",1440, 20, "Arial", 690 , 250, 0 , 0,i);
  string HM4 = iCustom(NULL, 0, "HeatMapModokiV1",10080, 20, "Arial", 725 , 250, 0 , 0,i);
  
  ColorPanel("Spread"+IntegerToString(i),labelcolor,C'61,61,61');        
  ColorPanel("Pips"+IntegerToString(i),labelcolor,C'61,61,61');
  ColorPanel("Adr"+IntegerToString(i),labelcolor,C'61,61,61');         
  ColorPanel("TP",Black,White);
  ColorPanel("TP1",Black,White);
  ColorPanel("TP2",Black,White);
  ColorPanel("TP3",Black,White);
  ColorPanel("TP4",Black,White);
  ColorPanel("TP5",Black,White);
  ColorPanel("A1"+IntegerToString(i),C'30,30,30',C'61,61,61');
  ColorPanel("A2"+IntegerToString(i),labelcolor,C'61,61,61');          
  ColorPanel("A3"+IntegerToString(i),C'30,30,30',C'61,61,61');   
  ColorPanel("B11"+IntegerToString(i),labelcolor1,labelcolor2);
  ColorPanel("B21"+IntegerToString(i),labelcolor3,labelcolor2);
  ColorPanel("B31"+IntegerToString(i),labelcolor4,labelcolor2);
  ColorPanel("B41"+IntegerToString(i),labelcolor5,labelcolor2);
  ColorPanel("B51"+IntegerToString(i),labelcolor6,labelcolor2);
  ColorPanel("B61"+IntegerToString(i),labelcolor7,labelcolor2);
  ColorPanel("B71"+IntegerToString(i),labelcolor8,labelcolor2);
  ColorPanel("B81"+IntegerToString(i),labelcolor9,labelcolor2);
  ColorPanel("B91"+IntegerToString(i),labelcolor10,labelcolor2);
  ColorPanel("B101"+IntegerToString(i),labelcolor11,labelcolor2);
  
  //ColorPanel("A13333"+IntegerToString(i),C'30,30,30',C'61,61,61');
  ColorPanel("A2333"+IntegerToString(i),labelcolor,C'61,61,61');          
  ColorPanel("A3333"+IntegerToString(i),C'30,30,30',C'61,61,61');   
  /*ColorPanel("B1333"+IntegerToString(i),labelcolor10,labelcolor20);
  ColorPanel("B2333"+IntegerToString(i),labelcolor30,labelcolor20);
  ColorPanel("B3333"+IntegerToString(i),labelcolor40,labelcolor20);
  ColorPanel("B4333"+IntegerToString(i),labelcolor50,labelcolor20);
  ColorPanel("B5333"+IntegerToString(i),labelcolor60,labelcolor20);
  ColorPanel("B6333"+IntegerToString(i),labelcolor70,labelcolor20);
  ColorPanel("B7333"+IntegerToString(i),labelcolor80,labelcolor20);
  ColorPanel("B8333"+IntegerToString(i),labelcolor90,labelcolor20);
  ColorPanel("B9333"+IntegerToString(i),labelcolor1000,labelcolor20);
  ColorPanel("B10333"+IntegerToString(i),labelcolor110,labelcolor20);*/
  
  ColorPanel("A222"+IntegerToString(i),labelcolor,C'61,61,61');// LINHA DE OPERAÇÃO VERDE
  ColorPanel("B2222"+IntegerToString(i),labelcolor,C'61,61,61');// LINHA DE OPERAÇÃO VERDE
  ColorPanel("A2223"+IntegerToString(i),labelcolor,C'61,61,61');// LINHA DE OPERAÇÃO VERDE
  ColorPanel("B22223"+IntegerToString(i),labelcolor,C'61,61,61');// LINHA DE OPERAÇÃO VERDE
  ColorPanel("A222333"+IntegerToString(i),labelcolor,C'61,61,61');// LINHA DE OPERAÇÃO VERDE
  ColorPanel("B2222333"+IntegerToString(i),labelcolor,C'61,61,61');// LINHA DE OPERAÇÃO VERDE
  //CANDLE DIRECTION
  ColorPanel("m1"+IntegerToString(i),clrNONE,clrBlack);
  ColorPanel("m5"+IntegerToString(i),clrBlack,White);
  ColorPanel("m15"+IntegerToString(i),clrBlack,C'0,0,0');
  ColorPanel("m30"+IntegerToString(i),clrBlack,C'0,0,0');
  ColorPanel("h1"+IntegerToString(i),clrBlack,C'0,0,0');
  ColorPanel("h4"+IntegerToString(i),clrBlack,C'0,0,0');
  ColorPanel("d1"+IntegerToString(i),clrBlack,C'0,0,0');
  ColorPanel("w1"+IntegerToString(i),clrBlack,C'0,0,0');
  ColorPanel("mn1"+IntegerToString(i),clrBlack,C'0,0,0');
  //CANDLE DIRECTION         
  //ColorPanel("A2"+IntegerToString(i),labelcolor,C'61,61,61');          
  ColorPanel("DIR"+IntegerToString(i),labelcolor,C'0,0,0');         
  }
  if (DashUpdate == 1)
  newm1 = iTime("AUDNZD"+postfix,PERIOD_M1,0);
  else if (DashUpdate == 5)
  newm1 = iTime("AUDNZD"+postfix,PERIOD_M5,0);
  }
  WindowRedraw();    
  }
//+------------------------------------------------------------------+
void SetText(string name,string text,int x,int y,color colour,int fontsize=12,double fontsize1=8,string fontface="Arial")
  {
  if (ObjectFind(0,name)<0)
  ObjectCreate(0,name,OBJ_LABEL,0,0,0);
  
  ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
  ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
  ObjectSetInteger(0,name,OBJPROP_COLOR,colour);
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,fontsize);
  ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
  ObjectSetString(0,name,OBJPROP_TEXT,text);
  ObjectSetString(0,name,OBJPROP_FONT,fontface);
  }
//+------------------------------------------------------------------+
void SetObjText(string name,string CharToStr,int x,int y,color colour,int fontsize=12,double fontsize1=8,string fontface="Wingdings")
  {
  if(ObjectFind(0,name)<0)
  ObjectCreate(0,name,OBJ_LABEL,0,0,0);
  
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,fontsize);
  ObjectSetInteger(0,name,OBJPROP_COLOR,colour);
  ObjectSetInteger(0,name,OBJPROP_BACK,false);
  ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
  ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
  ObjectSetString(0,name,OBJPROP_TEXT,CharToStr);
  ObjectSetString(0,name,OBJPROP_FONT,"Wingdings");
  }  
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SetPanel(string name,int sub_window,int x,int y,int width,int height,color bg_color,color border_clr,int border_width)
  {
  if(ObjectCreate(0,name,OBJ_RECTANGLE_LABEL,sub_window,0,0))
  {
  ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
  ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
  ObjectSetInteger(0,name,OBJPROP_XSIZE,width);
  ObjectSetInteger(0,name,OBJPROP_YSIZE,height);
  ObjectSetInteger(0,name,OBJPROP_COLOR,border_clr);
  ObjectSetInteger(0,name,OBJPROP_BORDER_TYPE,BORDER_FLAT);
  ObjectSetInteger(0,name,OBJPROP_WIDTH,border_width);
  ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
  ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
  ObjectSetInteger(0,name,OBJPROP_BACK,true);
  ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(0,name,OBJPROP_SELECTED,0);
  ObjectSetInteger(0,name,OBJPROP_HIDDEN,true);
  ObjectSetInteger(0,name,OBJPROP_ZORDER,0);
  }
  ObjectSetInteger(0,name,OBJPROP_BGCOLOR,bg_color);
  }
void ColorPanel(string name,color bg_color,color border_clr,color border_clr1=clrNONE,color fg_color=NULL)
  {
  ObjectSetInteger(0,name,OBJPROP_COLOR,border_clr);
  ObjectSetInteger(0,name,OBJPROP_BGCOLOR,bg_color);
  }
//+------------------------------------------------------------------+
void Create_Button(string but_name,string label,int xsize,int ysize,int xdist,int ydist,int bcolor,int fcolor,color bgcolor=clrBlack,
  color border_color=clrNONE,
  color fgcolor=clrWhite,
  string fontface="Arial",
  double fontsize=8,
  double fontsize1=8,
  bool selectable=false,
  bool selected=false,
  bool state=false)
  {
  if(ObjectFind(0,but_name)<0)
  {
  if(!ObjectCreate(0,but_name,OBJ_BUTTON,0,0,0))
  {
  Print(__FUNCTION__,
  ": failed to create the button! Error code = ",GetLastError());
  return;
  }
  ObjectSetString(0,but_name,OBJPROP_TEXT,label);
  ObjectSetInteger(0,but_name,OBJPROP_XSIZE,xsize);
  ObjectSetInteger(0,but_name,OBJPROP_YSIZE,ysize);
  ObjectSetInteger(0,but_name,OBJPROP_CORNER,CORNER_LEFT_UPPER);     
  ObjectSetInteger(0,but_name,OBJPROP_XDISTANCE,xdist);      
  ObjectSetInteger(0,but_name,OBJPROP_YDISTANCE,ydist);         
  ObjectSetInteger(0,but_name,OBJPROP_BGCOLOR,bcolor);
  ObjectSetInteger(0,but_name,OBJPROP_BGCOLOR,bgcolor);
  ObjectSetInteger(0,but_name,OBJPROP_BORDER_COLOR,border_color);
  ObjectSetInteger(0,but_name,OBJPROP_COLOR,fgcolor);
  ObjectSetInteger(0,but_name,OBJPROP_FONTSIZE,fontsize);
  ObjectSetInteger(0,but_name,OBJPROP_COLOR,fcolor);
  ObjectSetInteger(0,but_name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,but_name,OBJPROP_HIDDEN,true);
  //ObjectSetInteger(0,but_name,OBJPROP_BORDER_COLOR,ChartGetInteger(0,CHART_COLOR_FOREGROUND));
  ObjectSetInteger(0,but_name,OBJPROP_BORDER_TYPE,BORDER_RAISED);
  ObjectSetString(0,but_name,OBJPROP_FONT,fontface);

  //--- enable (true) or disable (false) the mode of moving the button by mouse
  ObjectSetInteger(0,but_name,OBJPROP_SELECTABLE,selectable);
  ObjectSetInteger(0,but_name,OBJPROP_SELECTED,selected);
  //--- set button state
  ObjectSetInteger(0,but_name,OBJPROP_STATE,state);
  //--- hide (true) or display (false) graphical object name in the object list

  ChartRedraw();      
  }
  }
void OnChartEvent(const int id,  const long &lparam, const double &dparam,  const string &sparam)
  {
  if(id==CHARTEVENT_OBJECT_CLICK)  
//BOTAO ACCOUNT MANAGER
  {
  }
if(sparam=="button_autotrade" && autotrade ==false)
  {
  autotrade =true;
  ObjectSetInteger(0,"button_autotrade",OBJPROP_BGCOLOR,Green);
  ObjectSetInteger(0,"button_autotrade",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_autotrade",OBJPROP_TEXT,"Autotrade");
  Sleep(100);ObjectSetInteger(0,"button_autotrade",OBJPROP_STATE,false);
  }
  else if(sparam=="button_autotrade" && autotrade ==true)
  {
  autotrade=false;
  ObjectSetInteger(0,"button_autotrade",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_autotrade",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_autotrade",OBJPROP_TEXT,"Manual");
  Sleep(100);ObjectSetInteger(0,"button_autotrade",OBJPROP_STATE,false); 
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_ShowProfitInfo" && ShowProfitInfo ==false)
  {
  ShowProfitInfo =true;
  ObjectSetInteger(0,"button_trigger_use_ShowProfitInfo",OBJPROP_BGCOLOR,Green);
  ObjectSetInteger(0,"button_trigger_use_ShowProfitInfo",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_trigger_use_ShowProfitInfo",OBJPROP_TEXT,"ProfitInfo");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_ShowProfitInfo",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_ShowProfitInfo"&& ShowProfitInfo ==true)
  {
  ShowProfitInfo =false;
  ObjectSetInteger(0,("button_trigger_use_ShowProfitInfo"),OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,("button_trigger_use_ShowProfitInfo"),OBJPROP_COLOR,White);
  ObjectSetString(0,("button_trigger_use_ShowProfitInfo"),OBJPROP_TEXT,"ProfitInfo");
  Sleep(100);ObjectSetInteger(0,("button_trigger_use_ShowProfitInfo"),OBJPROP_STATE,false); 
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_ShowTodayRanges" && ShowTodayRanges ==false)
  {
  ShowTodayRanges =true;
  ObjectSetInteger(0,"button_trigger_use_ShowTodayRanges",OBJPROP_BGCOLOR,Green);
  ObjectSetInteger(0,"button_trigger_use_ShowTodayRanges",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_trigger_use_ShowTodayRanges",OBJPROP_TEXT,"TodayRange");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_ShowTodayRanges",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_ShowTodayRanges"&& ShowTodayRanges ==true)
  {
  ShowTodayRanges =false;
  ObjectSetInteger(0,("button_trigger_use_ShowTodayRanges"),OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,("button_trigger_use_ShowTodayRanges"),OBJPROP_COLOR,White);
  ObjectSetString(0,("button_trigger_use_ShowTodayRanges"),OBJPROP_TEXT,"TodayRange");
  Sleep(100);ObjectSetInteger(0,("button_trigger_use_ShowTodayRanges"),OBJPROP_STATE,false); 
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_ShowRiskInfo" && ShowRiskInfo ==false)
  {
  ShowRiskInfo =true;
  ObjectSetInteger(0,"button_trigger_use_ShowRiskInfo",OBJPROP_BGCOLOR,Green);
  ObjectSetInteger(0,"button_trigger_use_ShowRiskInfo",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_trigger_use_ShowRiskInfo",OBJPROP_TEXT,"RiskInfo");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_ShowRiskInfo",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_ShowRiskInfo"&& ShowRiskInfo ==true)
  {
  ShowRiskInfo =false;
  ObjectSetInteger(0,("button_trigger_use_ShowRiskInfo"),OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,("button_trigger_use_ShowRiskInfo"),OBJPROP_COLOR,White);
  ObjectSetString(0,("button_trigger_use_ShowRiskInfo"),OBJPROP_TEXT,"RiskInfo");
  Sleep(100);ObjectSetInteger(0,("button_trigger_use_ShowRiskInfo"),OBJPROP_STATE,false); 
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_ShowAccountOrderInfo" && ShowAccountOrderInfo ==false)
  {
  ShowAccountOrderInfo =true;
  ObjectSetInteger(0,"button_trigger_use_ShowAccountOrderInfo",OBJPROP_BGCOLOR,Green);
  ObjectSetInteger(0,"button_trigger_use_ShowAccountOrderInfo",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_trigger_use_ShowAccountOrderInfo",OBJPROP_TEXT,"AccountOrder");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_ShowAccountOrderInfo",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_ShowAccountOrderInfo"&& ShowAccountOrderInfo ==true)
  {
  ShowAccountOrderInfo =false;
  ObjectSetInteger(0,("button_trigger_use_ShowAccountOrderInfo"),OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,("button_trigger_use_ShowAccountOrderInfo"),OBJPROP_COLOR,White);
  ObjectSetString(0,("button_trigger_use_ShowAccountOrderInfo"),OBJPROP_TEXT,"AccountOrder");
  Sleep(100);ObjectSetInteger(0,("button_trigger_use_ShowAccountOrderInfo"),OBJPROP_STATE,false); 
  }
//----------------------------------------------------------------
//---BOTAO INDICADORES  
  if(sparam=="button_trigger_use_Pips" && trigger_use_Pips ==false)
  {
  trigger_use_Pips =true;
  ObjectSetInteger(0,"button_trigger_use_Pips",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_Pips",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_Pips",OBJPROP_TEXT,"Pips");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_Pips",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_Pips" && trigger_use_Pips ==true)
  {
  trigger_use_Pips=false;
  ObjectSetInteger(0,"button_trigger_use_Pips",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_Pips",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_Pips",OBJPROP_TEXT,"Pips");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_Pips",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_bidratio" && trigger_use_bidratio ==false)
  {
  trigger_use_bidratio =true;
  ObjectSetInteger(0,"button_trigger_use_bidratio",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_bidratio",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_bidratio" && trigger_use_bidratio ==true)
  {
  trigger_use_bidratio=false;
  ObjectSetInteger(0,"button_trigger_use_bidratio",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_bidratio",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_bidratio00" && trigger_use_bidratio00 ==false)
  {
  trigger_use_bidratio00 =true;
  ObjectSetInteger(0,"button_trigger_use_bidratio00",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio00",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_bidratio00",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio00",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_bidratio00" && trigger_use_bidratio00 ==true)
  {
  trigger_use_bidratio00=false;
  ObjectSetInteger(0,"button_trigger_use_bidratio00",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio00",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_bidratio00",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio00",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_bidratio11" && trigger_use_bidratio11 ==false)
  {
  trigger_use_bidratio11 =true;
  ObjectSetInteger(0,"button_trigger_use_bidratio11",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio11",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_bidratio11",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio11",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_bidratio11" && trigger_use_bidratio11 ==true)
  {
  trigger_use_bidratio11=false;
  ObjectSetInteger(0,"button_trigger_use_bidratio11",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio11",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_bidratio11",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio11",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_bidratio22" && trigger_use_bidratio22 ==false)
  {
  trigger_use_bidratio22 =true;
  ObjectSetInteger(0,"button_trigger_use_bidratio22",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio22",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_bidratio22",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio22",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_bidratio22" && trigger_use_bidratio22 ==true)
  {
  trigger_use_bidratio22=false;
  ObjectSetInteger(0,"button_trigger_use_bidratio22",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio22",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_bidratio22",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio22",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_bidratio33" && trigger_use_bidratio33 ==false)
  {
  trigger_use_bidratio33 =true;
  ObjectSetInteger(0,"button_trigger_use_bidratio33",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio33",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_bidratio33",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio33",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_bidratio33" && trigger_use_bidratio33 ==true)
  {
  trigger_use_bidratio33=false;
  ObjectSetInteger(0,"button_trigger_use_bidratio33",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio33",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_bidratio33",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio33",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_bidratio44" && trigger_use_bidratio44 ==false)
  {
  trigger_use_bidratio44 =true;
  ObjectSetInteger(0,"button_trigger_use_bidratio44",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio44",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_bidratio44",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio44",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_bidratio44" && trigger_use_bidratio44 ==true)
  {
  trigger_use_bidratio44=false;
  ObjectSetInteger(0,"button_trigger_use_bidratio44",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio44",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_bidratio44",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio44",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_bidratio55" && trigger_use_bidratio55 ==false)
  {
  trigger_use_bidratio55 =true;
  ObjectSetInteger(0,"button_trigger_use_bidratio55",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio55",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_bidratio55",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio55",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_bidratio55" && trigger_use_bidratio55 ==true)
  {
  trigger_use_bidratio55=false;
  ObjectSetInteger(0,"button_trigger_use_bidratio55",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio55",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_bidratio55",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio55",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_bidratio66" && trigger_use_bidratio66 ==false)
  {
  trigger_use_bidratio66 =true;
  ObjectSetInteger(0,"button_trigger_use_bidratio66",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio66",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_bidratio66",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio66",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_bidratio66" && trigger_use_bidratio66 ==true)
  {
  trigger_use_bidratio66=false;
  ObjectSetInteger(0,"button_trigger_use_bidratio66",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio66",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_bidratio66",OBJPROP_TEXT,"BidRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio66",OBJPROP_STATE,false);
  }            
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_relstrength" && trigger_use_relstrength ==false)
  {
  trigger_use_relstrength =true;
  ObjectSetInteger(0,"button_trigger_use_relstrength",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_relstrength",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_relstrength" && trigger_use_relstrength ==true)
  {
  trigger_use_relstrength=false;
  ObjectSetInteger(0,"button_trigger_use_relstrength",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_relstrength",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_relstrength00" && trigger_use_relstrength00 ==false)
  {
  trigger_use_relstrength00 =true;
  ObjectSetInteger(0,"button_trigger_use_relstrength00",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength00",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_relstrength00",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength00",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_relstrength00" && trigger_use_relstrength00 ==true)
  {
  trigger_use_relstrength00=false;
  ObjectSetInteger(0,"button_trigger_use_relstrength00",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength00",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_relstrength00",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength00",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_relstrength11" && trigger_use_relstrength11 ==false)
  {
  trigger_use_relstrength11 =true;
  ObjectSetInteger(0,"button_trigger_use_relstrength11",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength11",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_relstrength11",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength11",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_relstrength11" && trigger_use_relstrength11 ==true)
  {
  trigger_use_relstrength11=false;
  ObjectSetInteger(0,"button_trigger_use_relstrength11",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength11",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_relstrength11",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength11",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_relstrength22" && trigger_use_relstrength22 ==false)
  {
  trigger_use_relstrength22 =true;
  ObjectSetInteger(0,"button_trigger_use_relstrength22",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength22",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_relstrength22",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength22",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_relstrength22" && trigger_use_relstrength22 ==true)
  {
  trigger_use_relstrength22=false;
  ObjectSetInteger(0,"button_trigger_use_relstrength22",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength22",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_relstrength22",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength22",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_relstrength33" && trigger_use_relstrength33 ==false)
  {
  trigger_use_relstrength33 =true;
  ObjectSetInteger(0,"button_trigger_use_relstrength33",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength33",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_relstrength33",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength33",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_relstrength33" && trigger_use_relstrength33 ==true)
  {
  trigger_use_relstrength33=false;
  ObjectSetInteger(0,"button_trigger_use_relstrength33",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength33",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_relstrength33",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength33",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_relstrength44" && trigger_use_relstrength44 ==false)
  {
  trigger_use_relstrength44 =true;
  ObjectSetInteger(0,"button_trigger_use_relstrength44",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength44",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_relstrength44",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength44",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_relstrength44" && trigger_use_relstrength44 ==true)
  {
  trigger_use_relstrength44=false;
  ObjectSetInteger(0,"button_trigger_use_relstrength44",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength44",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_relstrength44",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength44",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_relstrength55" && trigger_use_relstrength55 ==false)
  {
  trigger_use_relstrength55 =true;
  ObjectSetInteger(0,"button_trigger_use_relstrength55",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength55",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_relstrength55",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength55",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_relstrength55" && trigger_use_relstrength55 ==true)
  {
  trigger_use_relstrength55=false;
  ObjectSetInteger(0,"button_trigger_use_relstrength55",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength55",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_relstrength55",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength55",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_relstrength66" && trigger_use_relstrength66 ==false)
  {
  trigger_use_relstrength66 =true;
  ObjectSetInteger(0,"button_trigger_use_relstrength66",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength66",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_relstrength66",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength66",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_relstrength66" && trigger_use_relstrength66 ==true)
  {
  trigger_use_relstrength66=false;
  ObjectSetInteger(0,"button_trigger_use_relstrength66",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength66",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_relstrength66",OBJPROP_TEXT,"RStr");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength66",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_buysellratio" && trigger_use_buysellratio ==false)
  {
  trigger_use_buysellratio =true;
  ObjectSetInteger(0,"button_trigger_use_buysellratio",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_buysellratio",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_buysellratio",OBJPROP_TEXT,"BSRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_buysellratio",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_buysellratio" && trigger_use_buysellratio ==true)
  {
  trigger_use_buysellratio=false;
  ObjectSetInteger(0,"button_trigger_use_buysellratio",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_buysellratio",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_buysellratio",OBJPROP_TEXT,"BSRatio");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_buysellratio",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_gap" && trigger_use_gap ==false)
  {
  trigger_use_gap =true;
  ObjectSetInteger(0,"button_trigger_use_gap",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_gap",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_gap",OBJPROP_TEXT,"Gap");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_gap",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_gap" && trigger_use_gap ==true)
  {
  trigger_use_gap=false;
  ObjectSetInteger(0,"button_trigger_use_gap",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_gap",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_gap",OBJPROP_TEXT,"Gap");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_gap",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_UseHeatMap1" && trigger_UseHeatMap1 ==false)
  {
  trigger_UseHeatMap1 =true;
  ObjectSetInteger(0,"button_trigger_UseHeatMap1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap1",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_UseHeatMap1",OBJPROP_TEXT,"HM 5");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_UseHeatMap1" && trigger_UseHeatMap1 ==true)
  {
  trigger_UseHeatMap1=false;
  ObjectSetInteger(0,"button_trigger_UseHeatMap1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_UseHeatMap1",OBJPROP_TEXT,"HM 5");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap1",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_UseHeatMap2" && trigger_UseHeatMap2 ==false)
  {
  trigger_UseHeatMap2 =true;
  ObjectSetInteger(0,"button_trigger_UseHeatMap2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap2",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_UseHeatMap2",OBJPROP_TEXT,"HM 15");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap2",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_UseHeatMap2" && trigger_UseHeatMap2 ==true)
  {
  trigger_UseHeatMap2=false;
  ObjectSetInteger(0,"button_trigger_UseHeatMap2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap2",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_UseHeatMap2",OBJPROP_TEXT,"HM 15");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap2",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_UseHeatMap3" && trigger_UseHeatMap3 ==false)
  {
  trigger_UseHeatMap3 =true;
  ObjectSetInteger(0,"button_trigger_UseHeatMap3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap3",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_UseHeatMap3",OBJPROP_TEXT,"HM 30");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap3",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_UseHeatMap3" && trigger_UseHeatMap3 ==true)
  {
  trigger_UseHeatMap3=false;
  ObjectSetInteger(0,"button_trigger_UseHeatMap3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap3",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_UseHeatMap3",OBJPROP_TEXT,"HM 30");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap3",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_UseHeatMap4" && trigger_UseHeatMap4 ==false)
  {
  trigger_UseHeatMap4 =true;
  ObjectSetInteger(0,"button_trigger_UseHeatMap4",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap4",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_UseHeatMap4",OBJPROP_TEXT,"HM D1");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap4",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_UseHeatMap4" && trigger_UseHeatMap4 ==true)
  {
  trigger_UseHeatMap4=false;
  ObjectSetInteger(0,"button_trigger_UseHeatMap4",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap4",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_UseHeatMap4",OBJPROP_TEXT,"HM D1");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap4",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_UseHeatMap5" && trigger_UseHeatMap5 ==false)
  {
  trigger_UseHeatMap5 =true;
  ObjectSetInteger(0,"button_trigger_UseHeatMap5",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap5",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_UseHeatMap5",OBJPROP_TEXT,"HM W1");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap5",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_UseHeatMap5" && trigger_UseHeatMap5 ==true)
  {
  trigger_UseHeatMap5=false;
  ObjectSetInteger(0,"button_trigger_UseHeatMap5",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap5",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_UseHeatMap5",OBJPROP_TEXT,"HM W1");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap5",OBJPROP_STATE,false);
  }
//---BOTAO INDICADORES  
  if(sparam=="button_trigger_Moving_Average1" && trigger_Moving_Average1 ==false)//MM12
  {
  trigger_Moving_Average1 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average1",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Moving_Average1",OBJPROP_TEXT,"30");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average1" && trigger_Moving_Average1 ==true)
  {
  trigger_Moving_Average1=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average1",OBJPROP_TEXT,"30");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average1",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_Moving_Average2" && trigger_Moving_Average2 ==false)//MM12
  {
  trigger_Moving_Average2 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average2",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Moving_Average2",OBJPROP_TEXT,"30");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average2",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average2" && trigger_Moving_Average2 ==true)
  {
  trigger_Moving_Average2=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average2",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average2",OBJPROP_TEXT,"30");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average2",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_Moving_Average3" && trigger_Moving_Average3 ==false)//MM12
  {
  trigger_Moving_Average3 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average3",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Moving_Average3",OBJPROP_TEXT,"30");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average3",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average3" && trigger_Moving_Average3 ==true)
  {
  trigger_Moving_Average3=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average3",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average3",OBJPROP_TEXT,"30");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average3",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_Moving_Average4" && trigger_Moving_Average4 ==false)//MM21
  {
  trigger_Moving_Average4 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average4",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average4",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Moving_Average4",OBJPROP_TEXT,"45");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average4",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average4" && trigger_Moving_Average4 ==true)
  {
  trigger_Moving_Average4=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average4",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average4",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average4",OBJPROP_TEXT,"45");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average4",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_Moving_Average5" && trigger_Moving_Average5 ==false)//MM21
  {
  trigger_Moving_Average5 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average5",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average5",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Moving_Average5",OBJPROP_TEXT,"45");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average5",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average5" && trigger_Moving_Average5 ==true)
  {
  trigger_Moving_Average5=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average5",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average5",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average5",OBJPROP_TEXT,"45");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average5",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_Moving_Average6" && trigger_Moving_Average6 ==false)//MM21
  {
  trigger_Moving_Average6 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average6",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average6",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Moving_Average6",OBJPROP_TEXT,"45");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average6",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average6" && trigger_Moving_Average6 ==true)
  {
  trigger_Moving_Average6=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average6",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average6",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average6",OBJPROP_TEXT,"45");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average6",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_Moving_Average7" && trigger_Moving_Average7 ==false)//MM30
  {
  trigger_Moving_Average7 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average7",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average7",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Moving_Average7",OBJPROP_TEXT,"60");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average7",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average7" && trigger_Moving_Average7 ==true)
  {
  trigger_Moving_Average7=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average7",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average7",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average7",OBJPROP_TEXT,"60");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average7",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_Moving_Average8" && trigger_Moving_Average8 ==false)//MM30
  {
  trigger_Moving_Average8 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average8",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average8",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Moving_Average8",OBJPROP_TEXT,"60");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average8",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average8" && trigger_Moving_Average8 ==true)
  {
  trigger_Moving_Average8=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average8",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average8",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average8",OBJPROP_TEXT,"60");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average8",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_Moving_Average9" && trigger_Moving_Average9 ==false)//MM30
  {
  trigger_Moving_Average9 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average9",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average9",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Moving_Average9",OBJPROP_TEXT,"60");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average9",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average9" && trigger_Moving_Average9 ==true)
  {
  trigger_Moving_Average9=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average9",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average9",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average9",OBJPROP_TEXT,"60");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average9",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_Moving_Average10" && trigger_Moving_Average10 ==false)//MM50
  {
  trigger_Moving_Average10 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average10",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average10",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Moving_Average10",OBJPROP_TEXT,"75");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average10",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average10" && trigger_Moving_Average10 ==true)
  {
  trigger_Moving_Average10=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average10",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average10",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average10",OBJPROP_TEXT,"75");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average10",OBJPROP_STATE,false);
  }      
//----------------------------------------------------------------
  if(sparam=="button_trigger_Moving_Average11" && trigger_Moving_Average11 ==false)//MM50
  {
  trigger_Moving_Average11 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average11",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average11",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Moving_Average11",OBJPROP_TEXT,"75");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average11",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average11" && trigger_Moving_Average11 ==true)
  {
  trigger_Moving_Average11=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average11",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average11",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average11",OBJPROP_TEXT,"75");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average11",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_Moving_Average12" && trigger_Moving_Average12 ==false)//MM50
  {
  trigger_Moving_Average12 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average12",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average12",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Moving_Average12",OBJPROP_TEXT,"75");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average12",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average12" && trigger_Moving_Average12 ==true)
  {
  trigger_Moving_Average12=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average12",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average12",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average12",OBJPROP_TEXT,"75");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average12",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_Moving_Average13" && trigger_Moving_Average13 ==false)//MM100
  {
  trigger_Moving_Average13 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average13",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average13",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Moving_Average13",OBJPROP_TEXT,"90");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average13",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average13" && trigger_Moving_Average13 ==true)
  {
  trigger_Moving_Average13=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average13",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average13",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average13",OBJPROP_TEXT,"90");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average13",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_Moving_Average14" && trigger_Moving_Average14 ==false)//MM100
  {
  trigger_Moving_Average14 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average14",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average14",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Moving_Average14",OBJPROP_TEXT,"90");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average14",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average14" && trigger_Moving_Average14 ==true)
  {
  trigger_Moving_Average14=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average14",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average14",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average14",OBJPROP_TEXT,"90");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average14",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_Moving_Average15" && trigger_Moving_Average15 ==false)//MM100
  {
  trigger_Moving_Average15 =true;
  ObjectSetInteger(0,"button_trigger_Moving_Average15",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average15",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Moving_Average15",OBJPROP_TEXT,"90");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average15",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Moving_Average15" && trigger_Moving_Average15 ==true)
  {
  trigger_Moving_Average15=false;
  ObjectSetInteger(0,"button_trigger_Moving_Average15",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Moving_Average15",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Moving_Average15",OBJPROP_TEXT,"90");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Moving_Average15",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_UseCCI1" && UseCCI1 ==false)
  {
  UseCCI1 =true;
  ObjectSetInteger(0,"button_UseCCI1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseCCI1",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_UseCCI1",OBJPROP_TEXT,"CCI1");
  Sleep(100);ObjectSetInteger(0,"button_UseCCI1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseCCI1" && UseCCI1 ==true)
  {
  UseCCI1=false;
  ObjectSetInteger(0,"button_UseCCI1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseCCI1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_UseCCI1",OBJPROP_TEXT,"CCI1");
  Sleep(100);ObjectSetInteger(0,"button_UseCCI1",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_UseCCI2" && UseCCI2 ==false)
  {
  UseCCI2 =true;
  ObjectSetInteger(0,"button_UseCCI2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseCCI2",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_UseCCI2",OBJPROP_TEXT,"CCI2");
  Sleep(100);ObjectSetInteger(0,"button_UseCCI2",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseCCI2" && UseCCI2 ==true)
  {
  UseCCI2=false;
  ObjectSetInteger(0,"button_UseCCI2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseCCI2",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_UseCCI2",OBJPROP_TEXT,"CCI2");
  Sleep(100);ObjectSetInteger(0,"button_UseCCI2",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_UseCCI3" && UseCCI3 ==false)
  {
  UseCCI3 =true;
  ObjectSetInteger(0,"button_UseCCI3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseCCI3",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_UseCCI3",OBJPROP_TEXT,"CCI3");
  Sleep(100);ObjectSetInteger(0,"button_UseCCI3",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseCCI3" && UseCCI3 ==true)
  {
  UseCCI3=false;
  ObjectSetInteger(0,"button_UseCCI3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseCCI3",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_UseCCI3",OBJPROP_TEXT,"CCI3");
  Sleep(100);ObjectSetInteger(0,"button_UseCCI3",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_UseRSI1" && UseRSI1 ==false)
  {
  UseRSI1 =true;
  ObjectSetInteger(0,"button_UseRSI1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseRSI1",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_UseRSI1",OBJPROP_TEXT,"RSI1");
  Sleep(100);ObjectSetInteger(0,"button_UseRSI1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseRSI1" && UseRSI1 ==true)
  {
  UseRSI1=false;
  ObjectSetInteger(0,"button_UseRSI1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseRSI1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_UseRSI1",OBJPROP_TEXT,"RSI1");
  Sleep(100);ObjectSetInteger(0,"button_UseRSI1",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_UseRSI2" && UseRSI2 ==false)
  {
  UseRSI2 =true;
  ObjectSetInteger(0,"button_UseRSI2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseRSI2",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_UseRSI2",OBJPROP_TEXT,"RSI2");
  Sleep(100);ObjectSetInteger(0,"button_UseRSI2",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseRSI2" && UseRSI2 ==true)
  {
  UseRSI2=false;
  ObjectSetInteger(0,"button_UseRSI2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseRSI2",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_UseRSI2",OBJPROP_TEXT,"RSI2");
  Sleep(100);ObjectSetInteger(0,"button_UseRSI2",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_UseRSI3" && UseRSI3 ==false)
  {
  UseRSI3 =true;
  ObjectSetInteger(0,"button_UseRSI3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseRSI3",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_UseRSI3",OBJPROP_TEXT,"RSI3");
  Sleep(100);ObjectSetInteger(0,"button_UseRSI3",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseRSI3" && UseRSI3 ==true)
  {
  UseRSI3=false;
  ObjectSetInteger(0,"button_UseRSI3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseRSI3",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_UseRSI3",OBJPROP_TEXT,"RSI3");
  Sleep(100);ObjectSetInteger(0,"button_UseRSI3",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_MACD1" && trigger_MACD1 ==false)
  {
  trigger_MACD1 =true;
  ObjectSetInteger(0,"button_trigger_MACD1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_MACD1",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_MACD1",OBJPROP_TEXT,"MACD3");
  Sleep(100);ObjectSetInteger(0,"button_trigger_MACD1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_MACD1" && trigger_MACD1 ==true)
  {
  trigger_MACD1=false;
  ObjectSetInteger(0,"button_trigger_MACD1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_MACD1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_MACD1",OBJPROP_TEXT,"MACD1");
  Sleep(100);ObjectSetInteger(0,"button_trigger_MACD1",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_MACD2" && trigger_MACD2 ==false)
  {
  trigger_MACD2 =true;
  ObjectSetInteger(0,"button_trigger_MACD2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_MACD2",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_MACD2",OBJPROP_TEXT,"MACD2");
  Sleep(100);ObjectSetInteger(0,"button_trigger_MACD2",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_MACD2" && trigger_MACD2 ==true)
  {
  trigger_MACD2=false;
  ObjectSetInteger(0,"button_trigger_MACD2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_MACD2",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_MACD2",OBJPROP_TEXT,"MACD2");
  Sleep(100);ObjectSetInteger(0,"button_trigger_MACD2",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_MACD3" && trigger_MACD3 ==false)
  {
  trigger_MACD3 =true;
  ObjectSetInteger(0,"button_trigger_MACD3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_MACD3",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_MACD3",OBJPROP_TEXT,"MACD3");
  Sleep(100);ObjectSetInteger(0,"button_trigger_MACD3",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_MACD3" && trigger_MACD3 ==true)
  {
  trigger_MACD3=false;
  ObjectSetInteger(0,"button_trigger_MACD3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_MACD3",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_MACD3",OBJPROP_TEXT,"MACD3");
  Sleep(100);ObjectSetInteger(0,"button_trigger_MACD3",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_Candle_Direction" && trigger_Candle_Direction ==false)
  {
  trigger_Candle_Direction =true;
  ObjectSetInteger(0,"button_trigger_Candle_Direction",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_Direction",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Candle_Direction",OBJPROP_TEXT,"Candle Dir");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_Direction",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Candle_Direction" && trigger_Candle_Direction ==true)
  {
  trigger_Candle_Direction=false;
  ObjectSetInteger(0,"button_trigger_Candle_Direction",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_Direction",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Candle_Direction",OBJPROP_TEXT,"Candle Dir");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_Direction",OBJPROP_STATE,false);
  }
//PIPS
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_pips00" && trigger_use_pips00 ==false)
  {
  trigger_use_pips00 =true;
  ObjectSetInteger(0,"button_trigger_use_pips00",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_pips00",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_pips00",OBJPROP_TEXT,"P");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_pips00",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_pips00" && trigger_use_pips00 ==true)
  {
  trigger_use_pips00=false;
  ObjectSetInteger(0,"button_trigger_use_pips00",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_pips00",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_pips00",OBJPROP_TEXT,"P");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_pips00",OBJPROP_STATE,false);
  }
  //---
  //----------------------------------------------------------------
  if(sparam=="button_trigger_use_pips11" && trigger_use_pips11 ==false)
  {
  trigger_use_pips11 =true;
  ObjectSetInteger(0,"button_trigger_use_pips11",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_pips11",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_pips11",OBJPROP_TEXT,"P");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_pips11",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_pips11" && trigger_use_pips11 ==true)
  {
  trigger_use_pips11=false;
  ObjectSetInteger(0,"button_trigger_use_pips11",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_pips11",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_pips11",OBJPROP_TEXT,"P");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_pips11",OBJPROP_STATE,false);
  }
  //---
  //----------------------------------------------------------------
  if(sparam=="button_trigger_use_pips22" && trigger_use_pips22 ==false)
  {
  trigger_use_pips22 =true;
  ObjectSetInteger(0,"button_trigger_use_pips22",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_pips22",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_pips22",OBJPROP_TEXT,"P");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_pips22",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_pips22" && trigger_use_pips22 ==true)
  {
  trigger_use_pips22=false;
  ObjectSetInteger(0,"button_trigger_use_pips22",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_pips22",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_pips22",OBJPROP_TEXT,"P");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_pips22",OBJPROP_STATE,false);
  }
  //---
  //----------------------------------------------------------------
  if(sparam=="button_trigger_use_pips33" && trigger_use_pips33 ==false)
  {
  trigger_use_pips33 =true;
  ObjectSetInteger(0,"button_trigger_use_pips33",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_pips33",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_pips33",OBJPROP_TEXT,"P");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_pips33",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_pips33" && trigger_use_pips33 ==true)
  {
  trigger_use_pips33=false;
  ObjectSetInteger(0,"button_trigger_use_pips33",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_pips33",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_pips33",OBJPROP_TEXT,"P");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_pips33",OBJPROP_STATE,false);
  }
  //---
  //----------------------------------------------------------------
  if(sparam=="button_trigger_use_pips44" && trigger_use_pips44 ==false)
  {
  trigger_use_pips44 =true;
  ObjectSetInteger(0,"button_trigger_use_pips44",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_pips44",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_pips44",OBJPROP_TEXT,"P");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_pips44",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_pips44" && trigger_use_pips44 ==true)
  {
  trigger_use_pips44=false;
  ObjectSetInteger(0,"button_trigger_use_pips44",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_pips44",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_pips44",OBJPROP_TEXT,"P");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_pips44",OBJPROP_STATE,false);
  }
  //---
  //----------------------------------------------------------------
  if(sparam=="button_trigger_use_pips55" && trigger_use_pips55 ==false)
  {
  trigger_use_pips55 =true;
  ObjectSetInteger(0,"button_trigger_use_pips55",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_pips55",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_pips55",OBJPROP_TEXT,"P");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_pips55",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_pips55" && trigger_use_pips55 ==true)
  {
  trigger_use_pips55=false;
  ObjectSetInteger(0,"button_trigger_use_pips55",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_pips55",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_pips55",OBJPROP_TEXT,"P");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_pips55",OBJPROP_STATE,false);
  }
  //---
  //----------------------------------------------------------------
  if(sparam=="button_trigger_use_pips66" && trigger_use_pips66 ==false)
  {
  trigger_use_pips66 =true;
  ObjectSetInteger(0,"button_trigger_use_pips66",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_pips66",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_pips66",OBJPROP_TEXT,"P");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_pips66",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_pips66" && trigger_use_pips66 ==true)
  {
  trigger_use_pips66=false;
  ObjectSetInteger(0,"button_trigger_use_pips66",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_pips66",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_pips66",OBJPROP_TEXT,"P");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_pips66",OBJPROP_STATE,false);
  }
  //---

//PIPS
//SESSOES
  if(sparam=="button_UseSession1" && UseSession1 ==false)//LONDRES
  {
  UseSession1 =true;
  ObjectSetInteger(0,"button_UseSession1",OBJPROP_BGCOLOR,Green);
  ObjectSetInteger(0,"button_UseSession1",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_UseSession1",OBJPROP_TEXT,"12/16Hrs");
  Sleep(100);ObjectSetInteger(0,"button_UseSession1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseSession1" && UseSession1 ==true)
  {
  UseSession1=false;
  ObjectSetInteger(0,"button_UseSession1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseSession1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_UseSession1",OBJPROP_TEXT,"12/16Hrs");
  Sleep(100);ObjectSetInteger(0,"button_UseSession1",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_UseSession2" && UseSession2 ==false)//TOKIO
  {
  UseSession2 =true;
  ObjectSetInteger(0,"button_UseSession2",OBJPROP_BGCOLOR,Green);
  ObjectSetInteger(0,"button_UseSession2",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_UseSession2",OBJPROP_TEXT,"16/20Hrs");
  Sleep(100);ObjectSetInteger(0,"button_UseSession2",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseSession2" && UseSession2 ==true)
  {
  UseSession2=false;
  ObjectSetInteger(0,"button_UseSession2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseSession2",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_UseSession2",OBJPROP_TEXT,"16/20Hrs");
  Sleep(100);ObjectSetInteger(0,"button_UseSession2",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_UseSession3" && UseSession3 ==false)//NOVA YORK
  {
  UseSession3 =true;
  ObjectSetInteger(0,"button_UseSession3",OBJPROP_BGCOLOR,Green);
  ObjectSetInteger(0,"button_UseSession3",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_UseSession3",OBJPROP_TEXT,"20/24Hrs");
  Sleep(100);ObjectSetInteger(0,"button_UseSession3",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseSession3" && UseSession3 ==true)
  {
  UseSession3=false;
  ObjectSetInteger(0,"button_UseSession3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseSession3",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_UseSession3",OBJPROP_TEXT,"20/24Hrs");
  Sleep(100);ObjectSetInteger(0,"button_UseSession3",OBJPROP_STATE,false);
  }            
//----------------------------------------------------------------
  if(sparam=="button_UseSession4" && UseSession4 ==false)//NOVA YORK
  {
  UseSession4 =true;
  ObjectSetInteger(0,"button_UseSession4",OBJPROP_BGCOLOR,Green);
  ObjectSetInteger(0,"button_UseSession4",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_UseSession4",OBJPROP_TEXT,"00/04Hrs");
  Sleep(100);ObjectSetInteger(0,"button_UseSession4",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseSession4" && UseSession4 ==true)
  {
  UseSession4=false;
  ObjectSetInteger(0,"button_UseSession4",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseSession4",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_UseSession4",OBJPROP_TEXT,"00/04Hrs");
  Sleep(100);ObjectSetInteger(0,"button_UseSession4",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_UseSession5" && UseSession5 ==false)//NOVA YORK
  {
  UseSession5 =true;
  ObjectSetInteger(0,"button_UseSession5",OBJPROP_BGCOLOR,Green);
  ObjectSetInteger(0,"button_UseSession5",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_UseSession5",OBJPROP_TEXT,"04/08Hrs");
  Sleep(100);ObjectSetInteger(0,"button_UseSession5",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseSession5" && UseSession5 ==true)
  {
  UseSession5=false;
  ObjectSetInteger(0,"button_UseSession5",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseSession5",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_UseSession5",OBJPROP_TEXT,"04/08Hrs");
  Sleep(100);ObjectSetInteger(0,"button_UseSession5",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_UseSession6" && UseSession6 ==false)//NOVA YORK
  {
  UseSession6 =true;
  ObjectSetInteger(0,"button_UseSession6",OBJPROP_BGCOLOR,Green);
  ObjectSetInteger(0,"button_UseSession6",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_UseSession6",OBJPROP_TEXT,"08/12Hrs");
  Sleep(100);ObjectSetInteger(0,"button_UseSession6",OBJPROP_STATE,false);
  }
  else if(sparam=="button_UseSession6" && UseSession6 ==true)
  {
  UseSession6=false;
  ObjectSetInteger(0,"button_UseSession6",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_UseSession6",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_UseSession6",OBJPROP_TEXT,"08/12Hrs");
  Sleep(100);ObjectSetInteger(0,"button_UseSession6",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_Strength" && trigger_use_Strength ==false)//USD
  {
  trigger_use_Strength =true;
  ObjectSetInteger(0,"button_trigger_use_Strength",OBJPROP_BGCOLOR,Green);
  ObjectSetInteger(0,"button_trigger_use_Strength",OBJPROP_COLOR,White);
  ObjectSetString(0,"button_trigger_use_Strength",OBJPROP_TEXT,"Usd");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_Strength",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_Strength" && trigger_use_Strength ==true)
  {
  trigger_use_Strength=false;
  ObjectSetInteger(0,"button_trigger_use_Strength",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_Strength",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_Strength",OBJPROP_TEXT,"Usd");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_Strength",OBJPROP_STATE,false);
  }                                                     
//SESSOES               
//---------------------------------------------------------------------
/* //--------------------------------------------------------------------------------------------------------
       if(sparam==button_SB1)//plus button for Single & Basket LOT value
         {
            ObjectSetString(0,button_SB1,OBJPROP_TEXT,"Increase Hare LOT value...");
            S_BS_Lot=S_BS_Lot+.01;
            ObjectDelete(button_SB1);         
         }
       if(sparam==button_SB2)//minus button for Single & Basket LOT value
         {
            ObjectSetString(0,button_SB2,OBJPROP_TEXT,"Decrease Hare LOT value...");
            S_BS_Lot=S_BS_Lot-.01;
            if(S_BS_Lot<0.01){S_BS_Lot=0.01;}
            ObjectDelete(button_SB2);         
         }
//+++++++++
       if(sparam==button_SB3)//plus button for Single & Basket LOT value-00.X0
         {
            ObjectSetString(0,button_SB3,OBJPROP_TEXT,"Increase Hare LOT value...");
            S_BS_Lot=S_BS_Lot+.10;
            ObjectDelete(button_SB3);         
         }
       if(sparam==button_SB4)//minus button for Single & Basket LOT value
         {
            ObjectSetString(0,button_SB4,OBJPROP_TEXT,"Decrease TOR LOT value...");
            S_BS_Lot=S_BS_Lot-.10;
            //if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_SB4);         
         }
//++++++++++
       if(sparam==button_SB5)//plus button for Single & Basket LOT value-0X.00
         {
            ObjectSetString(0,button_SB5,OBJPROP_TEXT,"Increase HARE LOT value...");
            S_BS_Lot=S_BS_Lot+1.00;
            ObjectDelete(button_SB5);         
         }
       if(sparam==button_SB6)//minus button for Single & Basket LOT value
         {
            ObjectSetString(0,button_SB6,OBJPROP_TEXT,"Decrease HARE LOT value...");
            S_BS_Lot=S_BS_Lot-1.00;
            //if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_SB6);         
         }
//++++++++++
       if(sparam==button_SB7)//plus button for Single & Basket LOT value-X0.00
         {
            ObjectSetString(0,button_SB7,OBJPROP_TEXT,"Increase HARE LOT value...");
            S_BS_Lot=S_BS_Lot+10.00;
            ObjectDelete(button_SB7);         
         }
       if(sparam==button_SB8)//minus button for Single & Basket LOT value
         {
            ObjectSetString(0,button_SB8,OBJPROP_TEXT,"Decrease HARE LOT value...");
            S_BS_Lot=S_BS_Lot-10.00;
            //if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_SB8);         
         }
//--------------------------------------------------------------------------------------------------------
       if(sparam==button_SB9)//plus button for Single & Basket TP value
         {
            ObjectSetString(0,button_SB9,OBJPROP_TEXT,"Increase Hare TP value...");
            S_BS_TP=S_BS_TP+5;
            ObjectDelete(button_SB9);         
         }      
       if(sparam==button_SB10)//minus button for Single & Basket TP value
         {
            ObjectSetString(0,button_SB10,OBJPROP_TEXT,"Decrease Hare TP value...");
            S_BS_TP=S_BS_TP-5;
            if(S_BS_TP<0){S_BS_TP=0;}
            ObjectDelete(button_SB10);         
         }
//+-----------------------------------------------------------------------------
       if(sparam==button_SB11)//plus button for Single & Basket SL value
         {
            ObjectSetString(0,button_SB11,OBJPROP_TEXT,"Increase Hare TP value...");
            S_BS_SL=S_BS_SL+5;
            ObjectDelete(button_SB11);         
         }      
       if(sparam==button_SB12)//minus button for Single & Basket SL value
         {
            ObjectSetString(0,button_SB12,OBJPROP_TEXT,"Decrease Hare TP value...");
            S_BS_SL=S_BS_SL-5;
            if(S_BS_SL<0){S_BS_SL=0;}
            ObjectDelete(button_SB12);         
         }
//--------------------------------------------------------------------------------------------------------
       if(sparam==button_H1)//plus button for HARE LOT value
         {
            ObjectSetString(0,button_H1,OBJPROP_TEXT,"Increase Hare LOT value...");
            H_Lot=H_Lot+.01;
            ObjectDelete(button_H1);         
         }
       if(sparam==button_H2)//minus button for HARE LOT value
         {
            ObjectSetString(0,button_H2,OBJPROP_TEXT,"Decrease Hare LOT value...");
            H_Lot=H_Lot-.01;
            if(H_Lot<0.01){H_Lot=0.01;}
            ObjectDelete(button_H2);         
         }
//+++++++++
       if(sparam==button_H3)//plus button for HARE LOT value-00.X0
         {
            ObjectSetString(0,button_H3,OBJPROP_TEXT,"Increase Hare LOT value...");
            H_Lot=H_Lot+.10;
            ObjectDelete(button_H3);         
         }
       if(sparam==button_H4)//minus button for HARE LOT value
         {
            ObjectSetString(0,button_H4,OBJPROP_TEXT,"Decrease TOR LOT value...");
            H_Lot=H_Lot-.10;
            //if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_H4);         
         }
//++++++++++
       if(sparam==button_H5)//plus button for TORTOISE LOT value-0X.00
         {
            ObjectSetString(0,button_H5,OBJPROP_TEXT,"Increase HARE LOT value...");
            H_Lot=H_Lot+1.00;
            ObjectDelete(button_H5);         
         }
       if(sparam==button_H6)//minus button for HARE LOT value
         {
            ObjectSetString(0,button_H6,OBJPROP_TEXT,"Decrease HARE LOT value...");
            H_Lot=H_Lot-1.00;
            //if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_H6);         
         }
//++++++++++
       if(sparam==button_H7)//plus button for HARE LOT value-X0.00
         {
            ObjectSetString(0,button_H7,OBJPROP_TEXT,"Increase HARE LOT value...");
            H_Lot=H_Lot+10.00;
            ObjectDelete(button_H7);         
         }
       if(sparam==button_H8)//minus button for HARE LOT value
         {
            ObjectSetString(0,button_H8,OBJPROP_TEXT,"Decrease HARE LOT value...");
            H_Lot=H_Lot-10.00;
            //if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_H8);         
         }
//--------------------------------------------------------------------------------------------------------
       if(sparam==button_H9)//plus button for HARE TP value
         {
            ObjectSetString(0,button_H9,OBJPROP_TEXT,"Increase Hare TP value...");
            H_TP=H_TP+5;
            ObjectDelete(button_H9);         
         }      
       if(sparam==button_H10)//minus button for HARE TP value
         {
            ObjectSetString(0,button_H10,OBJPROP_TEXT,"Decrease Hare TP value...");
            H_TP=H_TP-5;
            if(H_TP<0){H_TP=0;}
            ObjectDelete(button_H10);         
         }
//+-----------------------------------------------------------------------------
       if(sparam==button_H11)//plus button for HARE SL value
         {
            ObjectSetString(0,button_H11,OBJPROP_TEXT,"Increase Hare TP value...");
            H_SL=H_SL+5;
            ObjectDelete(button_H11);         
         }      
       if(sparam==button_H12)//minus button for HARE SL value
         {
            ObjectSetString(0,button_H12,OBJPROP_TEXT,"Decrease Hare TP value...");
            H_SL=H_SL-5;
            if(H_SL<0){H_SL=0;}
            ObjectDelete(button_H12);         
         }
//--------------------------------------------------------------------------------------------------------
       if(sparam==button_T1)//plus button for TORTOISE LOT value-00.0X
         {
            ObjectSetString(0,button_T1,OBJPROP_TEXT,"Increase TOR LOT value...");
            TOR_Lot=TOR_Lot+.01;
            ObjectDelete(button_T1);         
         }
       if(sparam==button_T2)//minus button for HARE LOT value
         {
            ObjectSetString(0,button_T2,OBJPROP_TEXT,"Decrease TOR LOT value...");
            TOR_Lot=TOR_Lot-.01;
            if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_T2);         
         }
//++++++++++
       if(sparam==button_T3)//plus button for TORTOISE LOT value-00.X0
         {
            ObjectSetString(0,button_T3,OBJPROP_TEXT,"Increase TOR LOT value...");
            TOR_Lot=TOR_Lot+.10;
            ObjectDelete(button_T3);         
         }
       if(sparam==button_T4)//minus button for HARE LOT value
         {
            ObjectSetString(0,button_T4,OBJPROP_TEXT,"Decrease TOR LOT value...");
            TOR_Lot=TOR_Lot-.10;
            //if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_T4);         
         }
//++++++++++
       if(sparam==button_T5)//plus button for TORTOISE LOT value-0X.00
         {
            ObjectSetString(0,button_T5,OBJPROP_TEXT,"Increase TOR LOT value...");
            TOR_Lot=TOR_Lot+1.00;
            ObjectDelete(button_T5);         
         }
       if(sparam==button_T6)//minus button for HARE LOT value
         {
            ObjectSetString(0,button_T6,OBJPROP_TEXT,"Decrease TOR LOT value...");
            TOR_Lot=TOR_Lot-1.00;
            //if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_T6);         
         }
//++++++++++
       if(sparam==button_T7)//plus button for TORTOISE LOT value-X0.00
         {
            ObjectSetString(0,button_T7,OBJPROP_TEXT,"Increase TOR LOT value...");
            TOR_Lot=TOR_Lot+10.00;
            ObjectDelete(button_T7);         
         }
       if(sparam==button_T8)//minus button for HARE LOT value
         {
            ObjectSetString(0,button_T8,OBJPROP_TEXT,"Decrease TOR LOT value...");
            TOR_Lot=TOR_Lot-10.00;
            //if(TOR_Lot<0.01){TOR_Lot=0.01;}
            ObjectDelete(button_T8);         
         }
//--------------------------------------------------------------------------------------------------------
       if(sparam==button_T9)//plus button for TORTOISE TP value
         {
            ObjectSetString(0,button_T9,OBJPROP_TEXT,"Increase Tort TP value...");
            TOR_TP=TOR_TP+5;
            ObjectDelete(button_T9);         
         }      
       if(sparam==button_T10)//minus button for TORT TP value
         {
            ObjectSetString(0,button_T10,OBJPROP_TEXT,"Decrease Tort TP value...");
            TOR_TP=TOR_TP-5;
            if(TOR_TP<0){TOR_TP=0;}
            ObjectDelete(button_T10);         
         }
//+-----------------------------------------------------------------------------
       if(sparam==button_T11)//plus button for TORT SL value
         {
            ObjectSetString(0,button_T11,OBJPROP_TEXT,"Increase Tort TP value...");
            TOR_SL=TOR_SL+5;
            ObjectDelete(button_T11);         
         }      
       if(sparam==button_T12)//minus button for TORT SL value
         {
            ObjectSetString(0,button_T12,OBJPROP_TEXT,"Decrease Tort TP value...");
            TOR_SL=TOR_SL-5;
            if(TOR_SL<0){TOR_SL=0;}
            ObjectDelete(button_T12);         
       //  }

//----------------------------------------------------------------
   //  }
    //--- re-draw property values
   //ChartRedraw(); 
     }*/ 
  //{
//----------------------------------------------------------------
  if (sparam==button_reset_ea)
  {          
  Reset_EA();
  ObjectSetInteger(0,button_reset_ea,OBJPROP_STATE,0);
  return;
  }
//----------------------------------------------------------------
  if (sparam==button_close_basket_All)
  {
  ObjectSetString(0,button_close_basket_All,OBJPROP_TEXT,"Closing...");               
  close_basket(Magic_Number);
  ObjectSetInteger(0,button_close_basket_All,OBJPROP_STATE,0);
  ObjectSetString(0,button_close_basket_All,OBJPROP_TEXT,"Close Basket"); 
  return;
  }
//----------------------------------------------------------------
  if (sparam==button_close_basket_Prof)
  {
  ObjectSetString(0,button_close_basket_Prof,OBJPROP_TEXT,"Closing...");               
  close_profit();
  ObjectSetInteger(0,button_close_basket_Prof,OBJPROP_STATE,0);
  ObjectSetString(0,button_close_basket_Prof,OBJPROP_TEXT,"Close Basket"); 
  return;
  }
//----------------------------------------------------------------
  if (sparam==button_close_basket_Loss)
  {
  ObjectSetString(0,button_close_basket_Loss,OBJPROP_TEXT,"Closing...");               
  close_loss();
  ObjectSetInteger(0,button_close_basket_Loss,OBJPROP_STATE,0);
  ObjectSetString(0,button_close_basket_Loss,OBJPROP_TEXT,"Close Basket"); 
  return;
  }
//BOTAO LOTES
if(sparam==button_increase_lot)
  {
  lot+=lotStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
  if(sparam==button_decrease_lot)
  {
  if(lot>lotStep) lot-=lotStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
//BOTAO LOTES 
//BOTAO STOPSPIP
if(sparam==button_increase_Piptp)
  {
  Piptp+=PiptpStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
  if(sparam==button_decrease_Piptp)
  {
  if(Piptp>PiptpStep) Piptp-=PiptpStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
//----------------------------------------------------------------
  if(sparam==button_increase_Pipsl)
  {
  Pipsl+=PipslStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
  if(sparam==button_decrease_Pipsl)
  {
  if(Pipsl>PipslStep) Pipsl-=PipslStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
//BOTAO STOPSPIP
/*//BOTAO STOPSADR
if(sparam==button_increase_Adr1tp)
  {
  Adr1tp+=Adr1tpStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
  if(sparam==button_decrease_Adr1tp)
  {
  if(Adr1tp>Adr1tpStep) Adr1tp-=Adr1tpStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
//---  
  if(sparam==button_increase_Adr1sl)
  {
  Adr1sl+=Adr1slStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
  if(sparam==button_decrease_Adr1sl)
  {
  if(Adr1sl>Adr1slStep) Adr1sl-=Adr1slStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
//BOTAO STOPSADR*/  
       
//-----------------------------------------------------------------------------------------------------------------
  if (StringFind(sparam,"BUY") >= 0)
  {
  int ind = StringToInteger(sparam);
  ticket=OrderSend(TradePairs[ind],OP_BUY,lot,MarketInfo(TradePairs[ind],MODE_ASK),100,0,0,"HEDGE",Magic_Number,0,Blue);
  if (OrderSelect(ticket,SELECT_BY_TICKET) == true) {
  if (Pipsl != 0.0)
  stoploss=OrderOpenPrice() - Pipsl * pairinfo[ind].PairPip;
  else
  if (Adr1sl != 0.0)
  stoploss=OrderOpenPrice() - ((adrvalues[ind].adr10/100)*Adr1sl) * pairinfo[ind].PairPip;
  else
  stoploss = 0.0;
  
  if (Piptp != 0.0)
  takeprofit=OrderOpenPrice() + Piptp * pairinfo[ind].PairPip;
  else
  if (Adr1tp != 0.0)
  takeprofit=OrderOpenPrice() + ((adrvalues[ind].adr10/100)*Adr1tp) * pairinfo[ind].PairPip;
  else
  takeprofit = 0.0;
  OrderModify(ticket,OrderOpenPrice(),NormalizeDouble(stoploss,MarketInfo(TradePairs[ind],MODE_DIGITS)),NormalizeDouble(takeprofit,MarketInfo(TradePairs[ind],MODE_DIGITS)),0,clrBlue);
  }
  ObjectSetInteger(0,ind+"BUY",OBJPROP_STATE,0);
  ObjectSetString(0,ind+"BUY",OBJPROP_TEXT,"B"); 
  return;
  }
  
  string stato="SYMBOL";        
  if (StringFind(sparam,StringToInteger(sparam)+"Hold")>=0)
  { 
  if(ObjectGetInteger(0,StringToInteger(sparam)+"Hold",OBJPROP_STATE)==false){
  pairinfo[StringToInteger(sparam)].dux = false; 
  }else{pairinfo[StringToInteger(sparam)].dux = true; stato=TradePairs[StringToInteger(sparam)]; }       
  }
  ObjectSetString(0,"Hedge",OBJPROP_TEXT,"0.000");
  ObjectSetString(0,"Rep_Symb",OBJPROP_TEXT,stato);
  //ObjectSetString(0,"Rep_Symb",OBJPROP_TEXT,StringConcatenate(pairinfo[StringToInteger(sparam)].dux ,stato));
  
  if (StringFind(sparam,"SELL") >= 0)
  {
  int ind = StringToInteger(sparam);
  ticket=OrderSend(TradePairs[ind],OP_SELL,lot,MarketInfo(TradePairs[ind],MODE_BID),100,0,0,"HEDGE",Magic_Number,0,Red);
  if (OrderSelect(ticket,SELECT_BY_TICKET) == true) {
  if (Pipsl != 0.0)
  stoploss=OrderOpenPrice() + Pipsl * pairinfo[ind].PairPip;
  else
  if (Adr1sl != 0.0)
  stoploss=OrderOpenPrice()+((adrvalues[ind].adr10/100)*Adr1sl)  *pairinfo[ind].PairPip;
  else
  stoploss = 0.0;
  
  if (Piptp != 0.0)
  takeprofit=OrderOpenPrice() - Piptp * pairinfo[ind].PairPip;
  else 
  if (Adr1tp != 0.0)
  takeprofit=OrderOpenPrice() - ((adrvalues[ind].adr10/100)*Adr1tp) * pairinfo[ind].PairPip;
  else
  takeprofit = 0.0;
  OrderModify(ticket,OrderOpenPrice(),NormalizeDouble(stoploss,MarketInfo(TradePairs[ind],MODE_DIGITS)),NormalizeDouble(takeprofit,MarketInfo(TradePairs[ind],MODE_DIGITS)),0,clrBlue);
  }
  ObjectSetInteger(0,ind+"SELL",OBJPROP_STATE,0);
  ObjectSetString(0,ind+"SELL",OBJPROP_TEXT,"S");
  return;
  }
  if (StringFind(sparam,"CLOSE") >= 0)
  {
  int ind = StringToInteger(sparam);
  closeOpenOrders(TradePairs[ind]);               
  ObjectSetInteger(0,ind+"CLOSE",OBJPROP_STATE,0);
  ObjectSetString(0,ind+"CLOSE",OBJPROP_TEXT,"C");
  return;
  }
  
  if (StringFind(sparam,"Pair") >= 0) {
  int ind = StringToInteger(sparam);
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  OpenChart(ind);
  return;         
  }   
  //   }
//************   

  if(id==CHARTEVENT_OBJECT_ENDEDIT) 
  {
  string PFtext="10";
  if(ObjectGetString(0,sparam,OBJPROP_TEXT,0,PFtext))
  {
  if(StringFind(sparam,"minprofit",0)>=0)
  {
  ObjectSetString(0,sparam,OBJPROP_TEXT,DoubleToStr(PFtext,1)); goal = PFtext;
  }            
  }
  } 
  
 }
//----------------------------------------------------------------
void buy_basket(string &pairs[])
  {
  int i;
  int ticket;
   
  for(i=0;i<ArraySize(pairs);i++)
  {
  ticket=OrderSend(pairs[i],OP_BUY,lot,MarketInfo(pairs[i],MODE_ASK),100,0,0,NULL,Magic_Number,0,clrNONE);
  if (OrderSelect(ticket,SELECT_BY_TICKET) == true) {
  if (Pipsl != 0.0)
  stoploss=OrderOpenPrice() - Pipsl * pairinfo[i].PairPip;
  else
  if (Adr1sl != 0.0)
  stoploss=OrderOpenPrice() - ((adrvalues[i].adr20/100)*Adr1sl) * pairinfo[i].PairPip;
  else
  stoploss = 0.0;
  if (Piptp != 0.0)
  takeprofit=OrderOpenPrice() + Piptp * pairinfo[i].PairPip;
  else
  if (Adr1tp != 0.0)
  takeprofit=OrderOpenPrice() + ((adrvalues[i].adr20/100)*Adr1tp) * pairinfo[i].PairPip;
  else
  takeprofit = 0.0;
  OrderModify(ticket,OrderOpenPrice(),NormalizeDouble(stoploss,MarketInfo(pairs[i],MODE_DIGITS)),NormalizeDouble(takeprofit,MarketInfo(pairs[i],MODE_DIGITS)),0,clrBlue);
  }
  }
  }
//----------------------------------------------------------------
  void sell_basket(string &pairs[])
  {
  int i;
  int ticket;
  for(i=0;i<ArraySize(pairs);i++)
  {
  ticket=OrderSend(pairs[i],OP_SELL,lot,MarketInfo(pairs[i],MODE_BID),100,0,0,NULL,Magic_Number,0,clrNONE);
  if (OrderSelect(ticket,SELECT_BY_TICKET) == true) {
  if (Pipsl != 0.0)
  stoploss=OrderOpenPrice() + Pipsl * pairinfo[i].PairPip;
  else
  if (Adr1sl != 0.0)
  stoploss=OrderOpenPrice()+((adrvalues[i].adr20/100)*Adr1sl)  *pairinfo[i].PairPip;
  else
  stoploss = 0.0;
  if (Piptp != 0.0)
  takeprofit=OrderOpenPrice() - Piptp * pairinfo[i].PairPip;
  else 
  if (Adr1tp != 0.0)
  takeprofit=OrderOpenPrice() - ((adrvalues[i].adr20/100)*Adr1tp) * pairinfo[i].PairPip;
  else
  takeprofit = 0.0;
  OrderModify(ticket,OrderOpenPrice(),NormalizeDouble(stoploss,MarketInfo(pairs[i],MODE_DIGITS)),NormalizeDouble(takeprofit,MarketInfo(pairs[i],MODE_DIGITS)),0,clrBlue);
  }
  }
  }
//----------------------------------------------------------------
void close_cur_basket(string &pairs[])
  { 
  if (OrdersTotal() <= 0)
  return;
  int TradeList[][2];
  int ctTrade = 0;
  for (int i=0; i<OrdersTotal(); i++) 
  {
  OrderSelect(i, SELECT_BY_POS);
  if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)==true &&
  (OrderType()==0 || OrderType()==1) && 
  OrderMagicNumber()==Magic_Number &&
  InArray(pairs, OrderSymbol())) 
  {
  ctTrade++;
  ArrayResize(TradeList, ctTrade);
  TradeList[ctTrade-1][0] = OrderOpenTime();
  TradeList[ctTrade-1][1] = OrderTicket();
  }
  }
  ArraySort(TradeList,WHOLE_ARRAY,0,MODE_ASCEND);
  for (int i=0;i<ctTrade;i++) 
  {
  if (OrderSelect(TradeList[i][1], SELECT_BY_TICKET)==true) 
  {
  if (OrderType()==0)
  {
  ticket=OrderClose(OrderTicket(),OrderLots(), MarketInfo(OrderSymbol(),MODE_BID), 100, clrNONE);
  if (ticket==-1) Print ("Error: ",  GetLastError());
  }
  if (OrderType()==1)
  {
  ticket=OrderClose(OrderTicket(),OrderLots(), MarketInfo(OrderSymbol(),MODE_ASK), 100, clrNONE);
  if (ticket==-1) Print ("Error: ",  GetLastError());
  
  }  
  }
  Sleep(500);
  }  
  }
//+------------------------------------------------------------------+
//| closeOpenOrders                                                  |
//+------------------------------------------------------------------+
void closeOpenOrders(string closecurr )
  {
  int cnt = 0;  
  for (cnt = OrdersTotal()-1 ; cnt >= 0 ; cnt--)
  {
  if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)==true)
  {
  if(OrderType()==OP_BUY && OrderSymbol() == closecurr && OrderMagicNumber()==Magic_Number)
  ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),5,Violet);
  else if(OrderType()==OP_SELL && OrderSymbol() == closecurr && OrderMagicNumber()==Magic_Number) 
  ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_ASK),5,Violet);
  else if(OrderType()>OP_SELL) //pending orders
  ticket=OrderDelete(OrderTicket());
  }
  }
  }
void close_basket(int magic_number)
  { 
  if (OrdersTotal() <= 0)
  return;
  int TradeList[][2];
  int ctTrade = 0;
  for (int i=0; i<OrdersTotal(); i++) 
  {
  OrderSelect(i, SELECT_BY_POS);
  if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)==true && (OrderType()==0 || OrderType()==1) && OrderMagicNumber()==Magic_Number)
  {
  ctTrade++;
  ArrayResize(TradeList, ctTrade);
  TradeList[ctTrade-1][0] = OrderOpenTime();
  TradeList[ctTrade-1][1] = OrderTicket();
  }
  }
ArraySort(TradeList,WHOLE_ARRAY,0,MODE_ASCEND);
  for (int i=0;i<ctTrade;i++) 
  {
  if (OrderSelect(TradeList[i][1], SELECT_BY_TICKET)==true)
  {
  if (OrderType()==0)
  {
  ticket=OrderClose(OrderTicket(),OrderLots(), MarketInfo(OrderSymbol(),MODE_BID), 3,Red);
  if (ticket==-1) Print ("Error: ",  GetLastError());
  }
  if (OrderType()==1)
  {
  ticket=OrderClose(OrderTicket(),OrderLots(), MarketInfo(OrderSymbol(),MODE_ASK), 3,Red);
  if (ticket==-1) Print ("Error: ",  GetLastError());
  }  
  }
  }
  for (int i=0;i<ArraySize(TradePairs);i++)
  pairinfo[i].lastSignal = NOTHING; 
  currentlock = 0.0;
  trailstarted = false;   
  lockdistance = 0.0;    
  SymbolMaxDD = 0;
  SymbolMaxHi = 0;
  PercentFloatingSymbol=0;
  PercentMaxDDSymbol=0;    
  }
//----------------------------------------------------------------
void close_profit()
  {
  int cnt = 0; 
  for (cnt = OrdersTotal()-1 ; cnt >= 0 ; cnt--)
  {
  if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)==true)
  if (OrderProfit() > 0)
  {
  if(OrderType()==OP_BUY && OrderMagicNumber()==Magic_Number)
  ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),5,Violet);
  if(OrderType()==OP_SELL && OrderMagicNumber()==Magic_Number) 
  ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_ASK),5,Violet);
  if(OrderType()>OP_SELL)
  ticket=OrderDelete(OrderTicket());
  }
  } 
  }
//----------------------------------------------------------------
void close_loss()
  {
  int cnt = 0; 
  for (cnt = OrdersTotal()-1 ; cnt >= 0 ; cnt--)
  {
  if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)==true)
  if (OrderProfit() < 0)
  {
  if(OrderType()==OP_BUY && OrderMagicNumber()==Magic_Number)
  ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),5,Violet);
  if(OrderType()==OP_SELL && OrderMagicNumber()==Magic_Number) 
  ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_ASK),5,Violet);
  if(OrderType()>OP_SELL)
  ticket=OrderDelete(OrderTicket());
  }
  } 
  } 
//----------------------------------------------------------------
void Reset_EA()
  {
  currentlock = 0.0;
  trailstarted = false;   
  lockdistance = 0.0;    
  SymbolMaxDD = 0;
  SymbolMaxHi = 0;
  PercentFloatingSymbol=0;
  PercentMaxDDSymbol=0;
  OnInit();
  }
//+------------------------------------------------------------------+
void Trades()
  {
  int i, j;
  totallots=0;
  totalprofit=0;
  totaltrades = 0;
  
  for(i=0;i<ArraySize(TradePairs);i++)
  {
  
  bpos[i]=0;
  spos[i]=0;       
  blots[i]=0;
  slots[i]=0;     
  bprofit[i]=0;
  sprofit[i]=0;
  tprofit[i]=0;
  singolprofit[i] = 0; 
  
  BuyMin[i]         = 0;
  BuyMax[i]         = 0;
  BuyMinLot[i]      = 0;
  BuyTicProfit[i]   = 0;
  BuyMaxTic[i]      = 0;
  BuyProfit[i]      = 0; 
  
  SellMin[i]         = 0;
  SellMax[i]         = 0;
  SellMinLot[i]      = 0;
  SellTicProfit[i]   = 0;
  SellMaxTic[i]      = 0;
  SellProfit[i]      = 0;              
  }
  for(i=0;i<OrdersTotal();i++)
  {
  if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
  break;
  
  for(j=0;j<ArraySize(TradePairs);j++)
  {	  
  if((TradePairs[j]==OrderSymbol() || TradePairs[j]=="") && OrderMagicNumber()==Magic_Number)
  {
  TradePairs[j]=OrderSymbol();                       
  tprofit[j]=tprofit[j]+OrderProfit()+OrderSwap()+OrderCommission();           
  
  if(OrderType()==0){ bprofit[j]+=OrderProfit()+OrderSwap()+OrderCommission(); } 
  if(OrderType()==1){ sprofit[j]+=OrderProfit()+OrderSwap()+OrderCommission(); } 
  if(OrderType()==0){ blots[j]+=OrderLots(); } 
  if(OrderType()==1){ slots[j]+=OrderLots(); }
  if(OrderType()==0){ bpos[j]+=+1; } 
  if(OrderType()==1){ spos[j]+=+1; } 
  
  double BuyDist  = NormalizeDouble(MinStep*pairinfo[j].PairPip+MinStepPlus*pairinfo[j].PairPip*bpos[j],MarketInfo(TradePairs[j],MODE_DIGITS));
  double SellDist = NormalizeDouble(MinStep*pairinfo[j].PairPip+MinStepPlus*pairinfo[j].PairPip*spos[j],MarketInfo(TradePairs[j],MODE_DIGITS));
//--- hedge buy
  if(OrderType()==0) 
  {
  
  ProfitBuy[j]=0;
  
  if(OrderOpenPrice()<BuyMin[j] || BuyMin[j]==0)
  {
  BuyMin[j]=OrderOpenPrice();
  BuyMinLot[j]=OrderLots();           
  }
  
  if(OrderOpenPrice()>BuyMax[j] || BuyMin[j]==0)
  {
  BuyMax[j]=OrderOpenPrice();
  BuyMaxTic[j]=OrderTicket();
  BuyTicProfit[j]=OrderProfit();
  } 
  if(OrderProfit()>0)BuyProfit[j]+=OrderProfit()+OrderCommission()+OrderSwap();                
  }
  
  if(pairinfo[j].dux==true && bpos[j]) ObjectSetString(0,"Hedge",OBJPROP_TEXT,DoubleToStr(BuyMin[j]-BuyDist,5)); 
//--- hedge sell
  if(OrderType()==1) 
  {                         
  if(OrderOpenPrice()<SellMin[j] || SellMin[j]==0)
  {
  SellMin[j]=OrderOpenPrice();   
  SellMinLot[j]=OrderLots();           
  }
  
  if(OrderOpenPrice()>SellMax[j] || SellMin[j]==0)
  {
  SellMax[j]=OrderOpenPrice();    
  SellMaxTic[j]=OrderTicket();       
  SellTicProfit[j]=OrderProfit(); 
  } 
  if(OrderProfit()>0)SellProfit[j]+=OrderProfit()+OrderCommission()+OrderSwap();                
  }           
  
  if(pairinfo[j].dux==true && spos[j]==1) ObjectSetString(0,"Hedge",OBJPROP_TEXT,DoubleToStr(SellMax[j]+SellDist,5));
//---            
  if(bpos[j] + spos[j] >=2 && tprofit[j] > goal) { closeOpenOrders(TradePairs[j]); }
  
  if(OrderProfit()+OrderSwap()+OrderCommission() >0){              
  singolprofit[j]=OrderProfit()+OrderSwap()+OrderCommission();             
  if(bpos[j] + spos[j] <=1 && (bpos[j] ==1 || spos[j] ==1 ) && singolprofit[j] >goal) { OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),5,Purple); }}
//---                                             
  totallots=totallots+OrderLots();
  totaltrades++;
  totalprofit = totalprofit+OrderProfit()+OrderSwap()+OrderCommission();
  break;
  }	     
  }
  }
//---  
  if(OrdersTotal()==0)
  SetText("CTP","Sem Trades no Monitor",x_axis+315,y_axis+455,clrNONE,8);
  else
  SetText("CTP","Monitor Trades",x_axis+315,y_axis+455,clrNONE,8);
  if (inSession() == true)
  SetText("CTPT","Open Market",x_axis+1210,y_axis+220,clrLime,8);
  else
  SetText("CTPT","Mercado fechado",x_axis+1210,y_axis+220,clrRed,8);
//SetPanel("TP6",0,x_axis+95,y_axis-50,100,20,Black,White,1);
  }
//+------------------------------------------------------------------+ 
void OpenChart(int ind)
  {
  long nextchart = ChartFirst();
  do
  {
  string sym = ChartSymbol(nextchart);
  if (StringFind(sym,TradePairs[ind]) >= 0) 
  {
  ChartSetInteger(nextchart,CHART_BRING_TO_TOP,true);
  ChartSetSymbolPeriod(nextchart,TradePairs[ind],TimeFrame);
  ChartApplyTemplate(nextchart,usertemplate);
  return;
  }
  } 
  while ((nextchart = ChartNext(nextchart)) != -1);
  long newchartid = ChartOpen(TradePairs[ind],TimeFrame);
  ChartApplyTemplate(newchartid,usertemplate);
  }
//----------------------------------------------------------------
void TradeManager()
  {
  double AccBalance=AccountBalance();
  //- Target
  if(Basket_Target>0 && totalprofit>=Basket_Target) 
  {
  profitbaskets++;
  close_basket(Magic_Number);
  return;
  }
  //- StopLoss
  if(Basket_StopLoss>0 && totalprofit<(0-Basket_StopLoss)) 
  {
  lossbaskets++;
  close_basket(Magic_Number);
  return;
  }
  //- Out off session
  if(inSession() == false && totallots > 0.0 && CloseAllSession == true)
  {
  close_basket(Magic_Number);
  return;
  }
  //- Profit lock stoploss
  if (currentlock != 0.0 && totalprofit < currentlock)
  {
  profitbaskets++;
  close_basket(Magic_Number);
  return;
  }
  //- Profit lock trail
  if (trailstarted == true && totalprofit > currentlock + lockdistance)
  currentlock = totalprofit - lockdistance;

  if(totalprofit<=SymbolMaxDD) 
  {
  SymbolMaxDD=totalprofit;
  GetBalanceSymbol=AccBalance;
  }
  if(GetBalanceSymbol != 0)
  PercentMaxDDSymbol=(SymbolMaxDD*100)/GetBalanceSymbol;
  
  if(totalprofit>=SymbolMaxHi) 
  {
  SymbolMaxHi=totalprofit;
  GetBalanceSymbol=AccBalance;
  }
  if(GetBalanceSymbol != 0)
  PercentFloatingSymbol=(SymbolMaxHi*100)/GetBalanceSymbol;
  
  ObjectSetText("Lowest","Lowest= "+DoubleToStr(SymbolMaxDD,2)+" ("+DoubleToStr(PercentMaxDDSymbol,2)+"%)",8,NULL,BearColor);
  ObjectSetText("Highest","Highest= "+DoubleToStr(SymbolMaxHi,2)+" ("+DoubleToStr(PercentFloatingSymbol,2)+"%)",8,NULL,BullColor);
  ObjectSetText("Lock","Lock= "+DoubleToStr(currentlock,2),8,NULL,BullColor);
  ObjectSetText("Won",IntegerToString(profitbaskets,2),8,NULL,BullColor);
  ObjectSetText("Lost",IntegerToString(lossbaskets,2),8,NULL,BearColor);
  }
//----------------------------------------------------------------
//SIGNAL USD
void SetColors(int i) 
  {
  if(signals[i].Signalm1==1)  {Color=BullColor;}
  if(signals[i].Signalm1==-1) {Color=BearColor;}
  if(signals[i].Signalm5==1)  {Color1=BullColor;}         
  if(signals[i].Signalm5==-1) {Color1 =BearColor;}
  if(signals[i].Signalm15==1) {Color2 =BullColor;}
  if(signals[i].Signalm15==-1){Color2=BearColor;}
  if(signals[i].Signalm30==1) {Color3=BullColor;}
  if(signals[i].Signalm30==-1){Color3=BearColor;}
  if(signals[i].Signalh1==1)  {Color4=BullColor;}
  if(signals[i].Signalh1==-1) {Color4=BearColor;}
  if(signals[i].Signalh4==1)  {Color5=BullColor;}
  if(signals[i].Signalh4==-1) {Color5=BearColor;}
  if(signals[i].Signald1==1)  {Color6=BullColor;}
  if(signals[i].Signald1==-1) {Color6=BearColor;}
  if(signals[i].Signalw1==1)  {Color7=BullColor;}
  if(signals[i].Signalw1==-1) {Color7=BearColor;}
  if(signals[i].Signalmn==1)  {Color8=BullColor;}
  if(signals[i].Signalmn==-1) {Color8=BearColor;}
  if(signals[i].Signalusd>0)  {Color9=BullColor;}
  if(signals[i].Signalusd<0)  {Color9=BearColor;}
  if(signals[i].Signalperc>0) {Color12=BullColor;}
  if(signals[i].Signalperc<0) {Color12=BearColor;}
  
  if(signals[i].Signalusd>0)  {Color9=BullColor;}
  if(signals[i].Signalusd<0)  {Color9=BearColor;}
  if(signals[i].Signalperc>0) {Color12=BullColor;}
  if(signals[i].Signalperc<0) {Color12=BearColor;}
  
  if(signals[i].Signalusd>0.0)labelcolor1=clrGreen;     
  else if(signals[i].Signalusd<0.0)labelcolor1=clrRed;
  if(signals[i].Signalusd>10.0)labelcolor3=clrGreen;     
  else if(signals[i].Signalusd<-10.0)labelcolor3=clrRed;
  else labelcolor3=C'20,20,20'; 
  if(signals[i].Signalusd>20.0)labelcolor4=clrGreen;     
  else if(signals[i].Signalusd<-20.0)labelcolor4=clrRed;
  else labelcolor4=C'20,20,20';  
  if(signals[i].Signalusd>30.0)labelcolor5=clrGreen;     
  else if(signals[i].Signalusd<-30.0)labelcolor5=clrRed;
  else labelcolor5=C'20,20,20'; 
  if(signals[i].Signalusd>40.0)labelcolor6=clrGreen;     
  else if(signals[i].Signalusd<-40.0)labelcolor6=clrRed;
  else labelcolor6=C'20,20,20'; 
  if(signals[i].Signalusd>50.0)labelcolor7=clrGreen;     
  else if(signals[i].Signalusd<-50.0)labelcolor7=clrRed;
  else labelcolor7=C'20,20,20'; 
  if(signals[i].Signalusd>60.0)labelcolor8=clrGreen;     
  else if(signals[i].Signalusd<-60.0)labelcolor8=clrRed;
  else labelcolor8=C'20,20,20'; 
  if(signals[i].Signalusd>70.0)labelcolor9=clrGreen;     
  else if(signals[i].Signalusd<-70.0)labelcolor9=clrRed;
  else labelcolor9=C'20,20,20'; 
  if(signals[i].Signalusd>80.0)labelcolor10=clrGreen;     
  else if(signals[i].Signalusd<-80.0)labelcolor10=clrRed;
  else labelcolor10=C'20,20,20';  
  if(signals[i].Signalusd>90.0)labelcolor11=clrGreen;     
  else if(signals[i].Signalusd<-90.0)labelcolor11=clrRed;
  else labelcolor11=C'20,20,20';    
  }
//----------------------------------------------------------------
//SIGNAL USD       
void PlotTrades()
  {
  for (int i=0; i<ArraySize(TradePairs);i++){
  if(blots[i]>0){LotColor =clrLime;}        
  if(blots[i]==0){LotColor =C'61,61,61';}
  if(slots[i]>0){LotColor1 =clrRed;}        
  if(slots[i]==0){LotColor1 =C'61,61,61';}
  if(bpos[i]>0){OrdColor =clrLime;}        
  if(bpos[i]==0){OrdColor =C'61,61,61';}
  if(spos[i]>0){OrdColor1 =clrRed;}        
  if(spos[i]==0){OrdColor1 =C'61,61,61';}
  if(bprofit[i]>0){ProfitColor =BullColor;}
  if(bprofit[i]<0){ProfitColor =BearColor;}
  if(bprofit[i]==0){ProfitColor =C'61,61,61';}
  if(sprofit[i]>0){ProfitColor2 =BullColor;}
  if(sprofit[i]<0){ProfitColor2 =BearColor;}
  if(sprofit[i]==0){ProfitColor2 =C'61,61,61';}
  if(tprofit[i]>0){ProfitColor3 =clrLime;}
  if(tprofit[i]<0){ProfitColor3 =clrRed;}
  if(tprofit[i]==0){ProfitColor3 =C'61,61,61';}
  if(totalprofit>0){ProfitColor1 =clrLime;}
  if(totalprofit<0){ProfitColor1 =clrRed;}
  if(totalprofit==0){ProfitColor1 =C'61,61,61';}
  
  ObjectSetText("bLots"+IntegerToString(i),DoubleToStr(blots[i],2),6,C'61,61,61',LotColor);
  ObjectSetText("sLots"+IntegerToString(i),DoubleToStr(slots[i],2),6,C'61,61,61',LotColor1);
  ObjectSetText("bPos"+IntegerToString(i),DoubleToStr(bpos[i],0),6,C'61,61,61',OrdColor);
  ObjectSetText("sPos"+IntegerToString(i),DoubleToStr(spos[i],0),6,C'61,61,61',OrdColor1);
  ObjectSetText("TProf"+IntegerToString(i),DoubleToStr(MathAbs(bprofit[i]),2),6,C'61,61,61',ProfitColor);
  ObjectSetText("SProf"+IntegerToString(i),DoubleToStr(MathAbs(sprofit[i]),2),6,C'61,61,61',ProfitColor2);
  ObjectSetText("TtlProf"+IntegerToString(i),DoubleToStr(MathAbs(tprofit[i]),2),6,C'61,61,61',ProfitColor3);
  ObjectSetText("TotProf",DoubleToStr(MathAbs(totalprofit),2),25,C'61,61,61',ProfitColor1);
  }
  }
//----------------------------------------------------------------
void PlotAdrValues()
  {
  for (int i=0;i<ArraySize(TradePairs);i++)
  ObjectSetText("S1"+IntegerToString(i),DoubleToStr(adrvalues[i].adr,0),6,NULL,Yellow);
  }
bool inSession()
  {
  if ((localday != TimeDayOfWeek(TimeLocal()) && s1active == false && s2active == false && s3active == false && s4active == false && s5active == false && s6active == false) || localday == 99)
  {
  TimeToStruct(TimeLocal(),sess);
  StringSplit(sess1start,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s1start = StructToTime(sess);
  StringSplit(sess1end,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s1end = StructToTime(sess);
  StringSplit(sess2start,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s2start = StructToTime(sess);
  StringSplit(sess2end,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s2end = StructToTime(sess);
  StringSplit(sess3start,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s3start = StructToTime(sess);
  StringSplit(sess3end,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s3end = StructToTime(sess);
  StringSplit(sess4start,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s4start = StructToTime(sess);
  StringSplit(sess4end,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s4end = StructToTime(sess);
  StringSplit(sess5start,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s5start = StructToTime(sess);
  StringSplit(sess5end,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s5end = StructToTime(sess);
  StringSplit(sess6start,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s6start = StructToTime(sess);
  StringSplit(sess6end,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
  s6end = StructToTime(sess);
  
  if (s1end < s1start)
  s1end += 24*60*60;
  if (s2end < s2start)
  s2end += 24*60*60;
  if (s3end < s3start)
  s3end += 24*60*60;
  if (s4end < s4start)
  s4end += 24*60*60;
  if (s5end < s5start)
  s5end += 24*60*60;
  if (s6end < s6start)
  s6end += 24*60*60;
  
  newSession();
  localday = TimeDayOfWeek(TimeLocal());
  Print("Sessions for today");
  if (UseSession1 == true)
  Print("Session 1 From:"+s1start+" until "+s1end);
  if (UseSession2 == true)
  Print("Session 2 From:"+s2start+" until "+s2end);
  if (UseSession3 == true)
  Print("Session 3 From:"+s3start+" until "+s3end);
  if (UseSession4 == true)
  Print("Session 4 From:"+s4start+" until "+s4end);
  if (UseSession5 == true)
  Print("Session 5 From:"+s5start+" until "+s5end);
  if (UseSession6 == true)
  Print("Session 6 From:"+s6start+" until "+s6end);
  }

  if (UseSession1 && TimeLocal() >= s1start && TimeLocal() <= s1end)
  {
  comment = sess1comment;
  if (s1active == false)
  newSession();         
  else if ((StopProfit != 0 && profitbaskets >= StopProfit) || (StopLoss != 0 && lossbaskets >= StopLoss))
  return(false);
  s1active = true;
  return(true);
  }
  else
  {
  s1active = false;
  }   
  if (UseSession2 && TimeLocal() >= s2start && TimeLocal() <= s2end) 
  {
  comment = sess2comment;
  if (s2active == false)
  newSession();
  else if ((StopProfit != 0 && profitbaskets >= StopProfit) || (StopLoss != 0 && lossbaskets >= StopLoss))
  return(false);
  s2active = true;
  return(true);
  }
  else
  {
  s2active = false;
  }
  if (UseSession3 && TimeLocal() >= s3start && TimeLocal() <= s3end)
  {
  comment = sess3comment;
  if (s3active == false)
  newSession();
  else if ((StopProfit != 0 && profitbaskets >= StopProfit) || (StopLoss != 0 && lossbaskets >= StopLoss))
  return(false);
  s3active = true;
  return(true);
  } 
  else
  {
  s3active = false;
  }
  
  if (UseSession3 && TimeLocal() >= s3start && TimeLocal() <= s3end)
  {
  comment = sess3comment;
  if (s3active == false)
  newSession();
  else if ((StopProfit != 0 && profitbaskets >= StopProfit) || (StopLoss != 0 && lossbaskets >= StopLoss))
  return(false);
  s3active = true;
  return(true);
  } 
  else
  {
  s3active = false;
  }

  if (UseSession4 && TimeLocal() >= s4start && TimeLocal() <= s4end)
  {
  comment = sess4comment;
  if (s4active == false)
  newSession();
  else if ((StopProfit != 0 && profitbaskets >= StopProfit) || (StopLoss != 0 && lossbaskets >= StopLoss))
  return(false);
  s4active = true;
  return(true);
  } 
  else
  {
  s4active = false;
  }

  if (UseSession5 && TimeLocal() >= s5start && TimeLocal() <= s5end)
  {
  comment = sess5comment;
  if (s5active == false)
  newSession();
  else if ((StopProfit != 0 && profitbaskets >= StopProfit) || (StopLoss != 0 && lossbaskets >= StopLoss))
  return(false);
  s5active = true;
  return(true);
  } 
  else
  {
  s5active = false;
  }
  
  if (UseSession6 && TimeLocal() >= s6start && TimeLocal() <= s6end)
  {
  comment = sess6comment;
  if (s6active == false)
  newSession();
  else if ((StopProfit != 0 && profitbaskets >= StopProfit) || (StopLoss != 0 && lossbaskets >= StopLoss))
  return(false);
  s6active = true;
  return(true);
  } 
  else
  {
  s6active = false;
  }
  //---
  return(false);
  }
void newSession()
  {
  profitbaskets = 0;
  lossbaskets = 0;
  SymbolMaxDD = 0.0;
  PercentMaxDDSymbol = 0.0;
  SymbolMaxHi=0.0;
  PercentFloatingSymbol = 0.0;
  currentlock = 0.0;
  trailstarted = false;   
  lockdistance = 0.0;
  }
//-----------------------------------------------------------------------------
void ChngBoxCol(int mVal, int mBx)
  {
  if(mVal >= 0 && mVal < 10)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, clrWhite);
  if(mVal > 10 && mVal < 20)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BullColor);
  if(mVal > 20 && mVal < 30)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BullColor);
  if(mVal > 30 && mVal < 40)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BullColor);
  if(mVal > 40 && mVal < 50)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BullColor);
  if(mVal > 50 && mVal < 60)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BullColor);
  if(mVal > 60 && mVal < 70)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BullColor);
  if(mVal > 70 && mVal < 80)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BullColor);
  if(mVal > 80 && mVal < 90)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BullColor);
  if(mVal > 90 && mVal < 100)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BullColor);
  if(mVal > 100)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, clrSeaGreen);

  if(mVal < 0 && mVal > -10)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, clrWhite);
  if(mVal < -10 && mVal > -20)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BearColor);
  if(mVal < -20 && mVal > -30)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BearColor);
  if(mVal < -30 && mVal > -40)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BearColor);
  if(mVal < -40 && mVal > -50)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BearColor);
  if(mVal < -50 && mVal > -60)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BearColor);
  if(mVal < -60 && mVal >-70)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BearColor);
  if(mVal < -70 && mVal > -80)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BearColor);
  if(mVal < -80 && mVal > -90)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BearColor);
  if(mVal < -90)
  ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, BearColor);
  return;
  }
//----------------------------------------------------------------
void ChngBoxCol1(int mVal1, int mBx1)
  {
  if(mVal1 >= 0 && mVal1 < 10)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, clrWhite);
  if(mVal1 > 10 && mVal1 < 20)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);
  if(mVal1 > 20 && mVal1 < 30)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);
  if(mVal1 > 30 && mVal1 < 40)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);
  if(mVal1 > 40 && mVal1 < 50)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);
  if(mVal1 > 50 && mVal1 < 60)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);
  if(mVal1 > 60 && mVal1 < 70)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);
  if(mVal1 > 70 && mVal1 < 80)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);
  if(mVal1 > 80 && mVal1 < 90)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);
  if(mVal1 > 90 && mVal1 < 100)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);
  if(mVal1 > 100)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BullColor);

  if(mVal1 < 0 && mVal1 > -10)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, clrWhite);
  if(mVal1 < -10 && mVal1 > -20)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BearColor);
  if(mVal1 < -20 && mVal1 > -30)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BearColor);
  if(mVal1 < -30 && mVal1 > -40)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BearColor);
  if(mVal1 < -40 && mVal1 > -50)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BearColor);
  if(mVal1 < -50 && mVal1 > -60)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BearColor);
  if(mVal1 < -60 && mVal1 >-70)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BearColor);
  if(mVal1 < -70 && mVal1 > -80)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BearColor);
  if(mVal1 < -80 && mVal1 > -90)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BearColor);
  if(mVal1 < -90)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, BearColor);
  return;
  }
//----------------------------------------------------------------
void ChngBoxCol2(int mVal2, int mBx2)
  {
  if(mVal2 >= 0 && mVal2 < 10)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, clrWhite);
  if(mVal2 > 10 && mVal2 < 20)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);
  if(mVal2 > 20 && mVal2 < 30)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);
  if(mVal2 > 30 && mVal2 < 40)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);
  if(mVal2 > 40 && mVal2 < 50)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);
  if(mVal2 > 50 && mVal2 < 60)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);
  if(mVal2 > 60 && mVal2 < 70)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);
  if(mVal2 > 70 && mVal2 < 80)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);
  if(mVal2 > 80 && mVal2 < 90)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);
  if(mVal2 > 90 && mVal2 < 100)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);
  if(mVal2 > 100)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BullColor);

  if(mVal2 < 0 && mVal2 > -10)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, clrWhite);
  if(mVal2 < -10 && mVal2 > -20)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BearColor);
  if(mVal2 < -20 && mVal2 > -30)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BearColor);
  if(mVal2 < -30 && mVal2 > -40)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BearColor);
  if(mVal2 < -40 && mVal2 > -50)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BearColor);
  if(mVal2 < -50 && mVal2 > -60)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BearColor);
  if(mVal2 < -60 && mVal2 >-70)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BearColor);
  if(mVal2 < -70 && mVal2 > -80)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BearColor);
  if(mVal2 < -80 && mVal2 > -90)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BearColor);
  if(mVal2 < -90)
  ObjectSet("HM3"+mBx2, OBJPROP_BGCOLOR, BearColor);
  return;
  }
//----------------------------------------------------------------
void ChngBoxCol3(int mVal3, int mBx3)
  {
  if(mVal3 >= 0 && mVal3 < 10)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, clrWhite);
  if(mVal3 > 10 && mVal3 < 20)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);
  if(mVal3 > 20 && mVal3 < 30)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);
  if(mVal3 > 30 && mVal3 < 40)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);
  if(mVal3 > 40 && mVal3 < 50)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);
  if(mVal3 > 50 && mVal3 < 60)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);
  if(mVal3 > 60 && mVal3 < 70)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);
  if(mVal3 > 70 && mVal3 < 80)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);
  if(mVal3 > 80 && mVal3 < 90)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);
  if(mVal3 > 90 && mVal3 < 100)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);
  if(mVal3 > 100)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BullColor);

  if(mVal3 < 0 && mVal3 > -10)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, clrWhite);
  if(mVal3 < -10 && mVal3 > -20)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BearColor);
  if(mVal3 < -20 && mVal3 > -30)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BearColor);
  if(mVal3 < -30 && mVal3 > -40)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BearColor);
  if(mVal3 < -40 && mVal3 > -50)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BearColor);
  if(mVal3 < -50 && mVal3 > -60)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BearColor);
  if(mVal3 < -60 && mVal3 >-70)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BearColor);
  if(mVal3 < -70 && mVal3 > -80)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BearColor);
  if(mVal3 < -80 && mVal3 > -90)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BearColor);
  if(mVal3 < -90)
  ObjectSet("HM4"+mBx3, OBJPROP_BGCOLOR, BearColor);
  return;
  }
//----------------------------------------------------------------
void ChngBoxCol4(int mVal4, int mBx4)
  {
  if(mVal4 >= 0 && mVal4 < 10)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, clrWhite);
  if(mVal4 > 10 && mVal4 < 20)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);
  if(mVal4 > 20 && mVal4 < 30)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);
  if(mVal4 > 30 && mVal4 < 40)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);
  if(mVal4 > 40 && mVal4 < 50)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);
  if(mVal4 > 50 && mVal4 < 60)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);
  if(mVal4 > 60 && mVal4 < 70)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);
  if(mVal4 > 70 && mVal4 < 80)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);
  if(mVal4 > 80 && mVal4 < 90)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);
  if(mVal4 > 90 && mVal4 < 100)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);
  if(mVal4 > 100)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BullColor);

  if(mVal4 < 0 && mVal4 > -10)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, clrWhite);
  if(mVal4 < -10 && mVal4 > -20)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BearColor);
  if(mVal4 < -20 && mVal4 > -30)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BearColor);
  if(mVal4 < -30 && mVal4 > -40)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BearColor);
  if(mVal4 < -40 && mVal4 > -50)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BearColor);
  if(mVal4 < -50 && mVal4 > -60)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BearColor);
  if(mVal4 < -60 && mVal4 >-70)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BearColor);
  if(mVal4 < -70 && mVal4 > -80)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BearColor);
  if(mVal4 < -80 && mVal4 > -90)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BearColor);
  if(mVal4 < -90)
  ObjectSet("HM5"+mBx4, OBJPROP_BGCOLOR, BearColor);
  return;
  }
//----------------------------------------------------------------
bool InArray(string &pairs[], string symbol)
  {
  int arraysize = ArraySize(pairs);
  if(arraysize <= 0) return(false);
  if(symbol == NULL) return(false);
  int i;
  for(i=0;i<arraysize;i++)
  if(pairs[i] == symbol) return(true);
  return(false);
  }
//----------------------------------------------------------------
void PlotSpreadPips()
  {
  for (int i=0;i<ArraySize(TradePairs);i++)
  {
  if(MarketInfo(TradePairs[i],MODE_POINT) != 0 && pairinfo[i].pipsfactor != 0)
  {
  pairinfo[i].Pips = (iClose(TradePairs[i],periodPIP,0)-iOpen(TradePairs[i],periodPIP,0))/MarketInfo(TradePairs[i],MODE_POINT)/pairinfo[i].pipsfactor; 
  pairinfo[i].Pipsprev = (iClose(TradePairs[i],periodPIP,signals[i].shift+900)-iOpen(TradePairs[i],periodPIP,0))/MarketInfo(TradePairs[i],MODE_POINT)/pairinfo[i].pipsfactor;    
  pairinfo[i].Spread=MarketInfo(TradePairs[i],MODE_SPREAD)/pairinfo[i].pipsfactor;
  if(iClose(TradePairs[i], trigger_TF_HM1, 1)!=0)
  {
  signals[i].Signalperc = (iClose(TradePairs[i], 1, 0) - iClose(TradePairs[i], trigger_TF_HM1, 1)) / iClose(TradePairs[i], trigger_TF_HM1, 1) * 100;
  signals[i].Signalperc1 = (iClose(TradePairs[i], 1, 0) - iClose(TradePairs[i], trigger_TF_HM2, 1)) / iClose(TradePairs[i], trigger_TF_HM2, 1) * 100;    
  signals[i].Signalperc2 = (iClose(TradePairs[i], 1, 0) - iClose(TradePairs[i], trigger_TF_HM3, 1)) / iClose(TradePairs[i], trigger_TF_HM3, 1) * 100;
  signals[i].Signalperc3 = (iClose(TradePairs[i], 1, 0) - iClose(TradePairs[i], trigger_TF_HM4, 1)) / iClose(TradePairs[i], trigger_TF_HM4, 1) * 100;    
  signals[i].Signalperc4 = (iClose(TradePairs[i], 1, 0) - iClose(TradePairs[i], trigger_TF_HM5, 1)) / iClose(TradePairs[i], trigger_TF_HM5, 1) * 100;
  }    
  }  
  if(pairinfo[i].Pips>0){PipsColor =BullColor;
  }
  if(pairinfo[i].Pips<0){PipsColor =BearColor;
  } 
  if(pairinfo[i].Pips==0){PipsColor =clrWhite;
  }       
  if(pairinfo[i].Spread > MaxSpread)
  
  ObjectSetText("Spr1"+IntegerToString(i),DoubleToStr(pairinfo[i].Spread,1),6,NULL,Red);
  else
  ObjectSetText("Spr1"+IntegerToString(i),DoubleToStr(pairinfo[i].Spread,1),6,NULL,Orange);
  ObjectSetText("Pp1"+IntegerToString(i),DoubleToStr(MathAbs(pairinfo[i].Pips),0),6,NULL,PipsColor);
  
  if(pairinfo[i].Pips > pairinfo[i].Pipsprev)
  {
  pairinfo[i].PipsSig=UP;
  } 
  else
  {
  if(pairinfo[i].Pips < pairinfo[i].Pipsprev)
  pairinfo[i].PipsSig=DOWN;
  }  
  }
  }
//----------------------------------------------------------------
void GetAdrValues()
  {
  double s=0.0;
  for (int i=0;i<ArraySize(TradePairs);i++)
  {
  for(int a=1;a<=20;a++)
  {
  if(pairinfo[i].PairPip != 0)
  s=s+(iHigh(TradePairs[i],periodADR,a)-iLow(TradePairs[i],periodADR,a))/pairinfo[i].PairPip;
  if(a==1)
  adrvalues[i].adr1=MathRound(s);
  if(a==5)
  adrvalues[i].adr5=MathRound(s/5);
  if(a==10)
  adrvalues[i].adr10=MathRound(s/10);
  if(a==20)
  adrvalues[i].adr20=MathRound(s/20);
  }
  adrvalues[i].adr=MathRound((adrvalues[i].adr1+adrvalues[i].adr5+adrvalues[i].adr10+adrvalues[i].adr20)/4.0);
  s=0.0;
  }
  }
//----------------------------------------------------------------
void GetSignals() 
  {
  // CANDLE DIRECTION
  //void GetSignals() {
  for (int i=0;i<ArraySize(TradePairs);i++) 
  { // for (int i=0;i<ArraySize(signals);i++) {
  double Openm1    = iOpen(TradePairs[i], PERIOD_M1,0);
  double Closem1   = iClose(TradePairs[i],PERIOD_M1,0);
  double Openm5    = iOpen(TradePairs[i], PERIOD_M5,0);
  double Closem5   = iClose(TradePairs[i],PERIOD_M5,0);
  double Openm15   = iOpen(TradePairs[i], PERIOD_M15,0);
  double Closem15  = iClose(TradePairs[i],PERIOD_M15,0);
  double Openm30   = iOpen(TradePairs[i], PERIOD_M30,0);
  double Closem30  = iClose(TradePairs[i],PERIOD_M30,0);
  double Openh1    = iOpen(TradePairs[i], PERIOD_H1,0);
  double Closeh1   = iClose(TradePairs[i],PERIOD_H1,0);      
  double Openh4    = iOpen(TradePairs[i], PERIOD_H4,0);
  double Closeh4   = iClose(TradePairs[i],PERIOD_H4,0);
  double Opend     = iOpen(TradePairs[i], PERIOD_D1,0);
  double Closed    = iClose(TradePairs[i],PERIOD_D1,0);
  //double Openw     = iOpen(TradePairs[i], PERIOD_W1,0);
  //double Closew    = iClose(TradePairs[i],PERIOD_W1,0);
  //double Openmn    = iOpen(TradePairs[i], PERIOD_MN1,0);
  //double Closemn   = iClose(TradePairs[i],PERIOD_MN1,0);
      
  if(Closem1>Openm1)signals[i].SignalCDm1=UP;
  if(Closem1<Openm1)signals[i].SignalCDm1=DOWN;
  if(Closem5>Openm5)signals[i].SignalCDm5=UP;
  if(Closem5<Openm5)signals[i].SignalCDm5=DOWN;
  if(Closem15>Openm15)signals[i].SignalCDm15=UP;
  if(Closem15<Openm15)signals[i].SignalCDm15=DOWN;
  if(Closem30>Openm30)signals[i].SignalCDm30=UP;
  if(Closem30<Openm30)signals[i].SignalCDm30=DOWN;
  if(Closeh1>Openh1)signals[i].SignalCDh1=UP;
  if(Closeh1<Openh1)signals[i].SignalCDh1=DOWN;
  if(Closeh4>Openh4)signals[i].SignalCDh4=UP;
  if(Closeh4<Openh4)signals[i].SignalCDh4=DOWN;
  if(Closed>Opend)signals[i].SignalCDd1=UP;
  if(Closed<Opend)signals[i].SignalCDd1=DOWN;
  //if(Closew>Openw)signals[i].SignalCDw1=UP;
  //if(Closew<Openw)signals[i].SignalCDw1=DOWN;
  //if(Closemn>Openmn)signals[i].SignalCDmn=UP;
  //if(Closemn<Openmn)signals[i].SignalCDmn=DOWN;
  signals[i].Signaldirup=signals[i].SignalCDm1==UP&&signals[i].SignalCDm5==UP&&signals[i].SignalCDm15==UP&&signals[i].SignalCDm30==UP&&signals[i].SignalCDh1==UP&&signals[i].SignalCDh4==UP&&signals[i].SignalCDd1==UP/*&&signals[i].SignalCDw1==UP&&signals[i].SignalCDmn==UP*/;
  signals[i].Signaldirdn=signals[i].SignalCDm1==DOWN&&signals[i].SignalCDm5==DOWN&&signals[i].SignalCDm15==DOWN&&signals[i].SignalCDm30==DOWN&&signals[i].SignalCDh1==DOWN&&signals[i].SignalCDh4==DOWN&&signals[i].SignalCDd1==DOWN/*&&signals[i].SignalCDw1==DOWN&&signals[i].SignalCDmn==DOWN*/;
  } 
  //void GetSignals()
  //  {
  int cnt = 0;
  ArrayResize(signals,ArraySize(TradePairs));
  for (int i=0;i<ArraySize(signals);i++)
  {
  signals[i].symbol=TradePairs[i]; 
  signals[i].point=MarketInfo(signals[i].symbol,MODE_POINT);
  signals[i].open=iOpen(signals[i].symbol,periodBR0,0);      
  signals[i].close=iClose(signals[i].symbol,periodBR0,0);
  signals[i].hi=MarketInfo(signals[i].symbol,MODE_HIGH);
  signals[i].lo=MarketInfo(signals[i].symbol,MODE_LOW);
  signals[i].bid=MarketInfo(signals[i].symbol,MODE_BID);
  signals[i].range=(signals[i].hi-signals[i].lo);
  signals[i].shift = iBarShift(signals[i].symbol,PERIOD_M1,TimeCurrent()-periodBR0 * 60);
  signals[i].prevbid = iClose(signals[i].symbol,PERIOD_M1,signals[i].shift);
  signals[i].RSI = RSI_Value(signals[i].symbol);
  signals[i].highRatio=(signals[i].hi - signals[i].bid)/signals[i].point/10;
  signals[i].lowRatio=(signals[i].bid - signals[i].lo)/signals[i].point/10;
  if(signals[i].range!=0)
  {            
  signals[i].ratio=MathMin(((signals[i].bid-signals[i].lo)/signals[i].range*100 ),100);
  signals[i].prevratio=MathMin(((signals[i].prevbid-signals[i].lo)/signals[i].range*100 ),100);     
           
  for (int j = 0; j < 8; j++)
  {
  if(signals[i].ratio <= 3.0) signals[i].fact = 0;
  if(signals[i].ratio >  3.0) signals[i].fact = 1;
  if(signals[i].ratio >  10.0) signals[i].fact = 2;
  if(signals[i].ratio >  25.0) signals[i].fact = 3;
  if(signals[i].ratio >  40.0) signals[i].fact = 4;
  if(signals[i].ratio >  50.0) signals[i].fact = 5;
  if(signals[i].ratio >  60.0) signals[i].fact = 6;
  if(signals[i].ratio >  75.0) signals[i].fact = 7;
  if(signals[i].ratio >  90.0) signals[i].fact = 8;
  if(signals[i].ratio >  97.0) signals[i].fact = 9;
  cnt++;

  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].fact=9-signals[i].fact;
  
  if(curr[j]==StringSubstr(signals[i].symbol,0,3)) 
  {
  signals[i].strength1=signals[i].fact;
  }  
  else
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength2=signals[i].fact;
  }
  signals[i].calc =signals[i].strength1-signals[i].strength2;
  signals[i].strength=currency_strength(curr[j]);
  if(curr[j]==StringSubstr(signals[i].symbol,0,3))
  {
  signals[i].strength3=signals[i].strength;
  } 
  else
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength4=signals[i].strength;
  }
  signals[i].strength5=(signals[i].strength3-signals[i].strength4);
  signals[i].strength_old=old_currency_strength(curr[j]);
  if(curr[j]==StringSubstr(signals[i].symbol,0,3))
  {
  signals[i].strength6=signals[i].strength_old;
  } 
  else 
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength7=signals[i].strength_old;
  }
  signals[i].strength8=(signals[i].strength6-signals[i].strength7);     
  signals[i].strength_Gap=signals[i].strength5-signals[i].strength8;
  
  if(signals[i].ratio>=trigger_buy_bidratio)
  {
  signals[i].SigRatio=UP;
  } 
  else 
  {
  if(signals[i].ratio<=trigger_sell_bidratio)
  signals[i].SigRatio=DOWN;
  }  
  
  if(signals[i].ratio>signals[i].prevratio){
  signals[i].SigRatioPrev=UP;
  } 
  else 
  {
  if(signals[i].ratio<signals[i].prevratio)
  signals[i].SigRatioPrev=DOWN;
  }      
  
  if(signals[i].calc>=trigger_buy_relstrength){
  signals[i].SigRelStr=UP;
  } 
  else 
  {
  if (signals[i].calc<=trigger_sell_relstrength) 
  signals[i].SigRelStr=DOWN;
  } 
  
  if(signals[i].strength5>=trigger_buy_buysellratio){
  signals[i].SigBSRatio=UP;
  } 
  else 
  {
  if (signals[i].calc<=trigger_sell_buysellratio) 
  signals[i].SigBSRatio=DOWN;
  }       
  
  if(signals[i].strength_Gap>=trigger_gap_buy){
  signals[i].SigGap=UP;
  }
  if(signals[i].RSI>=trigger_buy_RSI){
  signals[i].SigRSI=UP;
  } 
  else 
  {
  if (signals[i].RSI<=trigger_sell_RSI) 
  signals[i].SigRSI=DOWN;
  }
  signals[i].SigGapPrev=NONE;
  if(signals[i].strength5>signals[i].xLBSr && signals[i].strength_Gap>=trigger_gap_buy && signals[i].strength_Gap>0)
  {
  signals[i].SigGapPrev=UP;
  } 
  if(signals[i].strength5<signals[i].xLBSr && signals[i].strength_Gap<=trigger_gap_sell && signals[i].strength_Gap<0)
  {      
  signals[i].SigGapPrev=DOWN;
  }  
  }
  }
  }    
  }
//----------------------------------------------------------------
color Colorstr(double tot) 
  {
  if(tot>=trigger_buy_bidratio)
  return (BullColor);
  if(tot<=trigger_sell_bidratio)
  return (BearColor);
  return (clrWhite);
  }  
color ColorBSRat(double tot) 
  {
  if(tot>=trigger_buy_buysellratio)
  return (BullColor);
  if(tot<=trigger_sell_buysellratio)
  return (BearColor);
  return (clrWhite);
  } 
color ColorGap(double tot) 
  {
  if(tot>=trigger_gap_buy)
  return (BullColor);
  if(tot<=trigger_gap_sell)
  return (BearColor);
  return (clrWhite);
  }
color ColorRSI(double tot) 
  {
  if(tot>=trigger_buy_RSI)
  return (BullColor);
  if(tot<=trigger_sell_RSI)
  return (BearColor);
  return (clrOrange);
  }            
//----------------------------------------------------------------
void displayMeter() 
  {
  double arrt[8][3];
  int arr2,arr3;
  arrt[0][0] = currency_strength(curr[0]);
  arrt[1][0] = currency_strength(curr[1]);
  arrt[2][0] = currency_strength(curr[2]);
  arrt[3][0] = currency_strength(curr[3]);
  arrt[4][0] = currency_strength(curr[4]);
  arrt[5][0] = currency_strength(curr[5]);
  arrt[6][0] = currency_strength(curr[6]);
  arrt[7][0] = currency_strength(curr[7]);
  arrt[0][2] = old_currency_strength(curr[0]);
  arrt[1][2] = old_currency_strength(curr[1]);
  arrt[2][2] = old_currency_strength(curr[2]);
  arrt[3][2] = old_currency_strength(curr[3]);
  arrt[4][2] = old_currency_strength(curr[4]);
  arrt[5][2] = old_currency_strength(curr[5]);
  arrt[6][2] = old_currency_strength(curr[6]);
  arrt[7][2] = old_currency_strength(curr[7]);
  arrt[0][1] = 0;
  arrt[1][1] = 1;
  arrt[2][1] = 2;
  arrt[3][1] = 3;
  arrt[4][1] = 4;
  arrt[5][1] = 5;
  arrt[6][1] = 6;
  arrt[7][1] = 7;
  ArraySort(arrt, WHOLE_ARRAY, 0, MODE_DESCEND);
  //--- GetMax
  int    maxValueIdx=ArrayMaximum(arrt,WHOLE_ARRAY,0); int Arr3 = arrt[maxValueIdx][1]; //Print(arrt[maxValueIdx][0],curr[Arr3]);
  //--- GetMin
  int    minValueIdx=ArrayMinimum(arrt,WHOLE_ARRAY,0); int Arr4 = arrt[minValueIdx][1]; //Print(arrt[maxValueIdx][0],curr[Arr4]);
     
  for (int m = 0; m < 8; m++) 
  {
  arr2 = arrt[m][1];
  arr3=(int)arrt[m][2];
  currstrength[m] = arrt[m][0];
  prevstrength[m] = arrt[m][2]; 
  SetText(curr[arr2]+"pos",IntegerToString(m+1)+".",(m*163)+x_axis+5,y_axis+588,color_for_profit(arrt[m][0]),10);//215/535
  SetText(curr[arr2]+"curr", curr[arr2],(m*163)+x_axis+10,y_axis+570,clrBlack,12);
  SetText(curr[arr2]+"currdig", DoubleToStr(arrt[m][0],1),(m*163)+x_axis+50,y_axis+570,clrBlack,12);
  SetPanel("Strength"+IntegerToString(m),0,(m*163)+x_axis+5,y_axis+570,157,20,color_for_profit(arrt[m][0]),C'61,61,61',1);
  
  if(currstrength[m] > prevstrength[m]){SetObjText("Sdir"+IntegerToString(m),CharToStr(217),(m*163)+x_axis+20,y_axis+588,BullColor,10);//282/535
  }
  else if(currstrength[m] < prevstrength[m]){SetObjText("Sdir"+IntegerToString(m),CharToStr(218),(m*163)+x_axis+20,y_axis+588,BearColor,10);//282/535
  }
  else {SetObjText("Sdir"+IntegerToString(m),CharToStr(243),(m*163)+x_axis+20,y_axis+588,clrYellow,10);//282/535
  }
  }
ChartRedraw(); 
  }


//----------------------------------------------------------------
  color color_for_profit(double total) 
  {
  /*if(total<2.0)
  return (BearColor);
  if(total<=3.0)
  return (BearColor);
  if(total>7.0)
  return (BullColor);
  if(total>6.0)
  return (BullColor);
  if(total>5.0)
  return (BullColor);
  if(total<=5.0)
  return (BearColor);       
  return(clrWhite);*/
  if(total<2.0)
  return (clrRed);
  if(total<=3.0)
  return (clrOrangeRed);
  if(total>7.0)
  return (clrLime);
  if(total>6.0)
  return (clrGreen);
  if(total>5.0)
  return (clrSandyBrown);
  if(total<=5.0)
  return (clrYellow);       
  return(clrSteelBlue);
  }

  double currency_strength(string pair)
  {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength = 0;
  int cnt1 = 0;
   for (int x = 0; x < ArraySize(TradePairs); x++) 
  {
  fact = 0;
  sym = TradePairs[x];
  if (pair == StringSubstr(sym, 0, 3) || pair == StringSubstr(sym, 3, 3)) 
  {
  // sym = sym + tempsym;
  range = (MarketInfo(sym, MODE_HIGH) - MarketInfo(sym, MODE_LOW)) ;
  if (range != 0.0) {
  ratio = 100.0 * ((MarketInfo(sym, MODE_BID) - MarketInfo(sym, MODE_LOW)) / range );
  //if (ratio <=  0.0) fact = 0;
  if (ratio > 3.0) fact = 1;
  if (ratio > 10.0) fact = 2;
  if (ratio > 25.0) fact = 3;
  if (ratio > 40.0) fact = 4;
  if (ratio > 50.0) fact = 5;
  if (ratio > 60.0) fact = 6;
  if (ratio > 75.0) fact = 7;
  if (ratio > 90.0) fact = 8;
  if (ratio > 97.0) fact = 9;
  cnt1++;
  if (pair == StringSubstr(sym, 3, 3)) fact= 9 - fact;
  strength += fact;
  // signals[x].strength += fact;
  }
  } 
  }
  // for (int x = 0; x < ArraySize(TradePairs); x++) 
  //if(cnt1!=0)signals[x].strength /= cnt1;
  if(cnt1!=0)strength /= cnt1;
  return (strength);
  }
//----------------------------------------------------------------
double old_currency_strength(string pair) 
  {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength=0;
  int cnt1=0;
  for(int x=0; x<ArraySize(TradePairs); x++) 
  {
  fact= 0;
  sym = TradePairs[x];
  int bar = iBarShift(TradePairs[x],PERIOD_M1,TimeCurrent()-60*periodBR0);
  double bid = iClose(TradePairs[x],PERIOD_M1,bar);
  if(pair==StringSubstr(sym,0,3) || pair==StringSubstr(sym,3,3)) 
  {
  // sym = sym + tempsym;
  range=(MarketInfo(sym,MODE_HIGH)-MarketInfo(sym,MODE_LOW));
  if(range!=0.0) 
  {
  ratio=100.0 *((bid-MarketInfo(sym,MODE_LOW))/range);
  if(ratio > 3.0) fact = 1;
  if(ratio > 10.0) fact = 2;
  if(ratio > 25.0) fact = 3;
  if(ratio > 40.0) fact = 4;
  if(ratio > 50.0) fact = 5;
  if(ratio > 60.0) fact = 6;
  if(ratio > 75.0) fact = 7;
  if(ratio > 90.0) fact = 8;
  if(ratio > 97.0) fact = 9;
  cnt1++;
  if(pair==StringSubstr(sym,3,3))
  fact= 9-fact;
  strength+=fact;
  }
  }
  }
  if(cnt1!=0)
  strength/=cnt1;
  return (strength);
  }
  
//----------------------------------------------------------------
color Colorsync(double tot) 
  {
  if(tot>=trigger_buy_relstrength)
  return (BullColor);
  if(tot<=trigger_sell_relstrength)
  return (BearColor);
  return (clrWhite);
  } 
//----------------------------------------------------------------
void get_list_status00(Pair &this_list00[]) 
  {
  ArrayResize(this_list00,ArraySize(TradePairs));
  for(int i=0; i<ArraySize(this_list00); i++)   
  {
  this_list00[i].symbol00=TradePairs[i];      
  this_list00[i].point00=MarketInfo(this_list00[i].symbol00,MODE_POINT);       
  this_list00[i].open00=iOpen(this_list00[i].symbol00,periodBR00,0);      
  this_list00[i].close00=iClose(this_list00[i].symbol00,periodBR00,0);
  this_list00[i].hi00=MarketInfo(this_list00[i].symbol00,MODE_HIGH);
  this_list00[i].lo00=MarketInfo(this_list00[i].symbol00,MODE_LOW);
  this_list00[i].ask00=MarketInfo(this_list00[i].symbol00,MODE_ASK);
  this_list00[i].bid00=MarketInfo(this_list00[i].symbol00,MODE_BID);
        
  if(this_list00[i].point00==0.0001 || this_list00[i].point00==0.01)
  this_list00[i].pipsfactor00=1;
  if(this_list00[i].point00==0.00001 || this_list00[i].point00==0.001)
  this_list00[i].pipsfactor00=10;
  if(this_list00[i].point00 !=0 && this_list00[i].pipsfactor00 != 0)
  { 
  this_list00[i].spread00=MarketInfo(this_list00[i].symbol00,MODE_SPREAD)/this_list00[i].pipsfactor00;
  this_list00[i].pips00=(this_list00[i].close00-this_list00[i].open00)/this_list00[i].point00/this_list00[i].pipsfactor00;
  } 
  if(this_list00[i].open00>this_list00[i].close00)
  {       
  this_list00[i].range00=(this_list00[i].hi00-this_list00[i].lo00)*this_list00[i].point00;      
  this_list00[i].ratio00=MathMin((this_list00[i].hi00-this_list00[i].close00)/this_list00[i].range00*this_list00[i].point00/ (-0.01),100);
  this_list00[i].calc00=this_list00[i].ratio00/(-10);
  }
  else if(this_list00[i].range00 !=0 )
  {
  this_list00[i].range00=(this_list00[i].hi00-this_list00[i].lo00)*this_list00[i].point00; 
  this_list00[i].ratio00=MathMin(100*(this_list00[i].close00-this_list00[i].lo00)/this_list00[i].range00*this_list00[i].point00,100);
  this_list00[i].calc00=this_list00[i].ratio00/10;
  }
  WindowRedraw();   
  }
// SORT THE TABLE!!!
  for(int i=0; 
  i<ArraySize(this_list00); 
  i++)
  for(int j=i; 
  j<ArraySize(this_list00); 
  j++) 
  {
  if(!Accending) 
  {
  if(this_list00[j].ratio00<this_list00[i].ratio00)
  swap(this_list00[i],this_list00[j]);
  } 
  else 
  {
  if(this_list00[j].ratio00>this_list00[i].ratio00)
  swap(this_list00[i],this_list00[j]);
  }
  }
  }   
//----------------------------------------------------------------
//RATIO LIST 11
//----------------------------------------------------------------
void get_list_status11(Pair &this_list11[]) 
  {
  ArrayResize(this_list11,ArraySize(TradePairs));
  for(int i=0; i<ArraySize(this_list11); i++)   
  {
  this_list11[i].symbol11=TradePairs[i];      
  this_list11[i].point11=MarketInfo(this_list11[i].symbol11,MODE_POINT);       
  this_list11[i].open11=iOpen(this_list11[i].symbol11,periodBR11,0);      
  this_list11[i].close11=iClose(this_list11[i].symbol11,periodBR11,0);
  this_list11[i].hi11=MarketInfo(this_list11[i].symbol11,MODE_HIGH);
  this_list11[i].lo11=MarketInfo(this_list11[i].symbol11,MODE_LOW);
  this_list11[i].ask11=MarketInfo(this_list11[i].symbol11,MODE_ASK);
  this_list11[i].bid11=MarketInfo(this_list11[i].symbol11,MODE_BID);
        
  if(this_list11[i].point11==0.0001 || this_list11[i].point11==0.01)
  this_list11[i].pipsfactor11=1;
  if(this_list11[i].point11==0.00001 || this_list11[i].point11==0.001)
  this_list11[i].pipsfactor11=10;
  if(this_list11[i].point11 !=0 && this_list11[i].pipsfactor11 != 0)
  { 
  this_list11[i].spread11=MarketInfo(this_list11[i].symbol11,MODE_SPREAD)/this_list11[i].pipsfactor11;
  this_list11[i].pips11=(this_list11[i].close11-this_list11[i].open11)/this_list11[i].point11/this_list11[i].pipsfactor11;
  } 
  if(this_list11[i].open11>this_list11[i].close11)
  {       
  this_list11[i].range11=(this_list11[i].hi11-this_list11[i].lo11)*this_list11[i].point11;      
  this_list11[i].ratio11=MathMin((this_list11[i].hi11-this_list11[i].close11)/this_list11[i].range11*this_list11[i].point11/ (-0.01),100);
  this_list11[i].calc11=this_list11[i].ratio11/(-10);
  }
  else if(this_list11[i].range11 !=0 )
  {
  this_list11[i].range11=(this_list11[i].hi11-this_list11[i].lo11)*this_list11[i].point11; 
  this_list11[i].ratio11=MathMin(100*(this_list11[i].close11-this_list11[i].lo11)/this_list11[i].range11*this_list11[i].point11,100);
  this_list11[i].calc11=this_list11[i].ratio11/10;
  }
  WindowRedraw();   
  }
// SORT THE TABLE!!!
  for(int i=0; 
  i<ArraySize(this_list11); 
  i++)
  for(int j=i; 
  j<ArraySize(this_list11); 
  j++) 
  {
  if(!Accending) 
  {
  if(this_list11[j].ratio11<this_list11[i].ratio11)
  swap(this_list11[i],this_list11[j]);
  } 
  else 
  {
  if(this_list11[j].ratio11>this_list11[i].ratio11)
  swap(this_list11[i],this_list11[j]);
  }
  }
  }   
//----------------------------------------------------------------
//RATIO LIST 22
//----------------------------------------------------------------
void get_list_status22(Pair &this_list22[]) 
  {
  ArrayResize(this_list22,ArraySize(TradePairs));
  for(int i=0; i<ArraySize(this_list22); i++)   
  {
  this_list22[i].symbol22=TradePairs[i];      
  this_list22[i].point22=MarketInfo(this_list22[i].symbol22,MODE_POINT);       
  this_list22[i].open22=iOpen(this_list22[i].symbol22,periodBR22,0);      
  this_list22[i].close22=iClose(this_list22[i].symbol22,periodBR22,0);
  this_list22[i].hi22=MarketInfo(this_list22[i].symbol22,MODE_HIGH);
  this_list22[i].lo22=MarketInfo(this_list22[i].symbol22,MODE_LOW);
  this_list22[i].ask22=MarketInfo(this_list22[i].symbol22,MODE_ASK);
  this_list22[i].bid22=MarketInfo(this_list22[i].symbol22,MODE_BID);
        
  if(this_list22[i].point22==0.0001 || this_list22[i].point22==0.01)
  this_list22[i].pipsfactor22=1;
  if(this_list22[i].point22==0.00001 || this_list22[i].point22==0.001)
  this_list22[i].pipsfactor22=10;
  if(this_list22[i].point22 !=0 && this_list22[i].pipsfactor22 != 0)
  { 
  this_list22[i].spread22=MarketInfo(this_list22[i].symbol22,MODE_SPREAD)/this_list22[i].pipsfactor22;
  this_list22[i].pips22=(this_list22[i].close22-this_list22[i].open22)/this_list22[i].point22/this_list22[i].pipsfactor22;
  } 
  if(this_list22[i].open22>this_list22[i].close22)
  {       
  this_list22[i].range22=(this_list22[i].hi22-this_list22[i].lo22)*this_list22[i].point22;      
  this_list22[i].ratio22=MathMin((this_list22[i].hi22-this_list22[i].close22)/this_list22[i].range22*this_list22[i].point22/ (-0.01),100);
  this_list22[i].calc22=this_list22[i].ratio22/(-10);
  }
  else if(this_list22[i].range22 !=0 )
  {
  this_list22[i].range22=(this_list22[i].hi22-this_list22[i].lo22)*this_list22[i].point22; 
  this_list22[i].ratio22=MathMin(100*(this_list22[i].close22-this_list22[i].lo22)/this_list22[i].range22*this_list22[i].point22,100);
  this_list22[i].calc22=this_list22[i].ratio22/10;
  }
  WindowRedraw();   
  }
// SORT THE TABLE!!!
  for(int i=0; 
  i<ArraySize(this_list22); 
  i++)
  for(int j=i; 
  j<ArraySize(this_list22); 
  j++) 
  {
  if(!Accending) 
  {
  if(this_list22[j].ratio22<this_list22[i].ratio22)
  swap(this_list22[i],this_list22[j]);
  } 
  else 
  {
  if(this_list22[j].ratio22>this_list22[i].ratio22)
  swap(this_list22[i],this_list22[j]);
  }
  }
  }   
//----------------------------------------------------------------
//RATIO LIST 33
//----------------------------------------------------------------
void get_list_status33(Pair &this_list33[]) 
  {
  ArrayResize(this_list33,ArraySize(TradePairs));
  for(int i=0; i<ArraySize(this_list33); i++)   
  {
  this_list33[i].symbol33=TradePairs[i];      
  this_list33[i].point33=MarketInfo(this_list33[i].symbol33,MODE_POINT);       
  this_list33[i].open33=iOpen(this_list33[i].symbol33,periodBR33,0);      
  this_list33[i].close33=iClose(this_list33[i].symbol33,periodBR33,0);
  this_list33[i].hi33=MarketInfo(this_list33[i].symbol33,MODE_HIGH);
  this_list33[i].lo33=MarketInfo(this_list33[i].symbol33,MODE_LOW);
  this_list33[i].ask33=MarketInfo(this_list33[i].symbol33,MODE_ASK);
  this_list33[i].bid33=MarketInfo(this_list33[i].symbol33,MODE_BID);
        
  if(this_list33[i].point33==0.0001 || this_list33[i].point33==0.01)
  this_list33[i].pipsfactor33=1;
  if(this_list33[i].point33==0.00001 || this_list33[i].point33==0.001)
  this_list33[i].pipsfactor33=10;
  if(this_list33[i].point33 !=0 && this_list33[i].pipsfactor33 != 0)
  { 
  this_list33[i].spread33=MarketInfo(this_list33[i].symbol33,MODE_SPREAD)/this_list33[i].pipsfactor33;
  this_list33[i].pips33=(this_list33[i].close33-this_list33[i].open33)/this_list33[i].point33/this_list33[i].pipsfactor33;
  } 
  if(this_list33[i].open33>this_list33[i].close33)
  {       
  this_list33[i].range33=(this_list33[i].hi33-this_list33[i].lo33)*this_list33[i].point33;      
  this_list33[i].ratio33=MathMin((this_list33[i].hi33-this_list33[i].close33)/this_list33[i].range33*this_list33[i].point33/ (-0.01),100);
  this_list33[i].calc33=this_list33[i].ratio33/(-10);
  }
  else if(this_list33[i].range33 !=0 )
  {
  this_list33[i].range33=(this_list33[i].hi33-this_list33[i].lo33)*this_list33[i].point33; 
  this_list33[i].ratio33=MathMin(100*(this_list33[i].close33-this_list33[i].lo33)/this_list33[i].range33*this_list33[i].point33,100);
  this_list33[i].calc33=this_list33[i].ratio33/10;
  }
  WindowRedraw();   
  }
// SORT THE TABLE!!!
  for(int i=0; 
  i<ArraySize(this_list33); 
  i++)
  for(int j=i; 
  j<ArraySize(this_list33); 
  j++) 
  {
  if(!Accending) 
  {
  if(this_list33[j].ratio33<this_list33[i].ratio33)
  swap(this_list33[i],this_list33[j]);
  } 
  else 
  {
  if(this_list33[j].ratio33>this_list33[i].ratio33)
  swap(this_list33[i],this_list33[j]);
  }
  }
  }   
//----------------------------------------------------------------
//RATIO LIST 44
//----------------------------------------------------------------
void get_list_status44(Pair &this_list44[]) 
  {
  ArrayResize(this_list44,ArraySize(TradePairs));
  for(int i=0; i<ArraySize(this_list44); i++)   
  {
  this_list44[i].symbol44=TradePairs[i];      
  this_list44[i].point44=MarketInfo(this_list44[i].symbol44,MODE_POINT);       
  this_list44[i].open44=iOpen(this_list44[i].symbol44,periodBR44,0);      
  this_list44[i].close44=iClose(this_list44[i].symbol44,periodBR44,0);
  this_list44[i].hi44=MarketInfo(this_list44[i].symbol44,MODE_HIGH);
  this_list44[i].lo44=MarketInfo(this_list44[i].symbol44,MODE_LOW);
  this_list44[i].ask44=MarketInfo(this_list44[i].symbol44,MODE_ASK);
  this_list44[i].bid44=MarketInfo(this_list44[i].symbol44,MODE_BID);
        
  if(this_list44[i].point44==0.0001 || this_list44[i].point44==0.01)
  this_list44[i].pipsfactor44=1;
  if(this_list44[i].point44==0.00001 || this_list44[i].point44==0.001)
  this_list44[i].pipsfactor44=10;
  if(this_list44[i].point44 !=0 && this_list44[i].pipsfactor44 != 0)
  { 
  this_list44[i].spread44=MarketInfo(this_list44[i].symbol44,MODE_SPREAD)/this_list44[i].pipsfactor44;
  this_list44[i].pips44=(this_list44[i].close44-this_list44[i].open44)/this_list44[i].point44/this_list44[i].pipsfactor44;
  } 
  if(this_list44[i].open44>this_list44[i].close44)
  {       
  this_list44[i].range44=(this_list44[i].hi44-this_list44[i].lo44)*this_list44[i].point44;      
  this_list44[i].ratio44=MathMin((this_list44[i].hi44-this_list44[i].close44)/this_list44[i].range44*this_list44[i].point44/ (-0.01),100);
  this_list44[i].calc44=this_list44[i].ratio44/(-10);
  }
  else if(this_list44[i].range44 !=0 )
  {
  this_list44[i].range44=(this_list44[i].hi44-this_list44[i].lo44)*this_list44[i].point44; 
  this_list44[i].ratio44=MathMin(100*(this_list44[i].close44-this_list44[i].lo44)/this_list44[i].range44*this_list44[i].point44,100);
  this_list44[i].calc44=this_list44[i].ratio44/10;
  }
  WindowRedraw();   
  }
// SORT THE TABLE!!!
  for(int i=0; 
  i<ArraySize(this_list44); 
  i++)
  for(int j=i; 
  j<ArraySize(this_list44); 
  j++) 
  {
  if(!Accending) 
  {
  if(this_list44[j].ratio44<this_list44[i].ratio44)
  swap(this_list44[i],this_list44[j]);
  } 
  else 
  {
  if(this_list44[j].ratio44>this_list44[i].ratio44)
  swap(this_list44[i],this_list44[j]);
  }
  }
  }   
//----------------------------------------------------------------
//RATIO LIST 55
//----------------------------------------------------------------
void get_list_status55(Pair &this_list55[]) 
  {
  ArrayResize(this_list55,ArraySize(TradePairs));
  for(int i=0; i<ArraySize(this_list55); i++)   
  {
  this_list55[i].symbol55=TradePairs[i];      
  this_list55[i].point55=MarketInfo(this_list55[i].symbol55,MODE_POINT);       
  this_list55[i].open55=iOpen(this_list55[i].symbol55,periodBR55,0);      
  this_list55[i].close55=iClose(this_list55[i].symbol55,periodBR55,0);
  this_list55[i].hi55=MarketInfo(this_list55[i].symbol55,MODE_HIGH);
  this_list55[i].lo55=MarketInfo(this_list55[i].symbol55,MODE_LOW);
  this_list55[i].ask55=MarketInfo(this_list55[i].symbol55,MODE_ASK);
  this_list55[i].bid55=MarketInfo(this_list55[i].symbol55,MODE_BID);
        
  if(this_list55[i].point55==0.0001 || this_list55[i].point55==0.01)
  this_list55[i].pipsfactor55=1;
  if(this_list55[i].point55==0.00001 || this_list55[i].point55==0.001)
  this_list55[i].pipsfactor55=10;
  if(this_list55[i].point55 !=0 && this_list55[i].pipsfactor55 != 0)
  { 
  this_list55[i].spread55=MarketInfo(this_list55[i].symbol55,MODE_SPREAD)/this_list55[i].pipsfactor55;
  this_list55[i].pips55=(this_list55[i].close55-this_list55[i].open55)/this_list55[i].point55/this_list55[i].pipsfactor55;
  } 
  if(this_list55[i].open55>this_list55[i].close55)
  {       
  this_list55[i].range55=(this_list55[i].hi55-this_list55[i].lo55)*this_list55[i].point55;      
  this_list55[i].ratio55=MathMin((this_list55[i].hi55-this_list55[i].close55)/this_list55[i].range55*this_list55[i].point55/ (-0.01),100);
  this_list55[i].calc55=this_list55[i].ratio55/(-10);
  }
  else if(this_list55[i].range55 !=0 )
  {
  this_list55[i].range55=(this_list55[i].hi55-this_list55[i].lo55)*this_list55[i].point55; 
  this_list55[i].ratio55=MathMin(100*(this_list55[i].close55-this_list55[i].lo55)/this_list55[i].range55*this_list55[i].point55,100);
  this_list55[i].calc55=this_list55[i].ratio55/10;
  }
  WindowRedraw();   
  }
// SORT THE TABLE!!!
  for(int i=0; 
  i<ArraySize(this_list55); 
  i++)
  for(int j=i; 
  j<ArraySize(this_list55); 
  j++) 
  {
  if(!Accending) 
  {
  if(this_list55[j].ratio55<this_list55[i].ratio55)
  swap(this_list55[i],this_list55[j]);
  } 
  else 
  {
  if(this_list55[j].ratio55>this_list55[i].ratio55)
  swap(this_list55[i],this_list55[j]);
  }
  }
  }   
//----------------------------------------------------------------
//RATIO LIST 66
//----------------------------------------------------------------
void get_list_status66(Pair &this_list66[]) 
  {
  ArrayResize(this_list66,ArraySize(TradePairs));
  for(int i=0; i<ArraySize(this_list66); i++)   
  {
  this_list66[i].symbol66=TradePairs[i];      
  this_list66[i].point66=MarketInfo(this_list66[i].symbol66,MODE_POINT);       
  this_list66[i].open66=iOpen(this_list66[i].symbol66,periodBR66,0);      
  this_list66[i].close66=iClose(this_list66[i].symbol66,periodBR66,0);
  this_list66[i].hi66=MarketInfo(this_list66[i].symbol66,MODE_HIGH);
  this_list66[i].lo66=MarketInfo(this_list66[i].symbol66,MODE_LOW);
  this_list66[i].ask66=MarketInfo(this_list66[i].symbol66,MODE_ASK);
  this_list66[i].bid66=MarketInfo(this_list66[i].symbol66,MODE_BID);
        
  if(this_list66[i].point66==0.0001 || this_list66[i].point66==0.01)
  this_list66[i].pipsfactor66=1;
  if(this_list66[i].point66==0.00001 || this_list66[i].point66==0.001)
  this_list66[i].pipsfactor66=10;
  if(this_list66[i].point66 !=0 && this_list66[i].pipsfactor66 != 0)
  { 
  this_list66[i].spread66=MarketInfo(this_list66[i].symbol66,MODE_SPREAD)/this_list66[i].pipsfactor66;
  this_list66[i].pips66=(this_list66[i].close66-this_list66[i].open66)/this_list66[i].point66/this_list66[i].pipsfactor66;
  } 
  if(this_list66[i].open66>this_list66[i].close66)
  {       
  this_list66[i].range66=(this_list66[i].hi66-this_list66[i].lo66)*this_list66[i].point66;      
  this_list66[i].ratio66=MathMin((this_list66[i].hi66-this_list66[i].close66)/this_list66[i].range66*this_list66[i].point66/ (-0.01),100);
  this_list66[i].calc66=this_list66[i].ratio66/(-10);
  }
  else if(this_list66[i].range66 !=0 )
  {
  this_list66[i].range66=(this_list66[i].hi66-this_list66[i].lo66)*this_list66[i].point66; 
  this_list66[i].ratio66=MathMin(100*(this_list66[i].close66-this_list66[i].lo66)/this_list66[i].range66*this_list66[i].point66,100);
  this_list66[i].calc66=this_list66[i].ratio66/10;
  }
  WindowRedraw();   
  }
// SORT THE TABLE!!!
  for(int i=0; 
  i<ArraySize(this_list66); 
  i++)
  for(int j=i; 
  j<ArraySize(this_list66); 
  j++) 
  {
  if(!Accending) 
  {
  if(this_list66[j].ratio66<this_list66[i].ratio66)
  swap(this_list66[i],this_list66[j]);
  } 
  else 
  {
  if(this_list66[j].ratio66>this_list66[i].ratio66)
  swap(this_list66[i],this_list66[j]);
  }
  }
  }   
//----------------------------------------------------------------
/*void GetSignals1() 
  {
  ArrayResize(signals,ArraySize(TradePairs));
  for (int i=0;i<ArraySize(signals);
  i++) 
  {
  signals[i].symbol3=TradePairs[i]; 
  signals[i].point3=MarketInfo(signals[i].symbol3,MODE_POINT);
  signals[i].digit3=MarketInfo(signals[i].symbol3,MODE_DIGITS);
  signals[i].open3=iOpen(signals[i].symbol3,PERIOD_CURRENT,0);      
  signals[i].close3=iClose(signals[i].symbol3,PERIOD_CURRENT,0);
  signals[i].high3=MarketInfo(signals[i].symbol3,MODE_HIGH);
  signals[i].low3=MarketInfo(signals[i].symbol3,MODE_LOW);
  signals[i].bid3=MarketInfo(signals[i].symbol3,MODE_BID);
  signals[i].ask3=MarketInfo(signals[i].symbol3,MODE_ASK);
  if((signals[i].high3-signals[i].low3) !=0)
  {
  signals[i].bidratio3=((signals[i].bid3-signals[i].low3)/(signals[i].high3-signals[i].low3)*100);
  signals[i].range3=((signals[i].high3-signals[i].low3)/signals[i].point3/pairinfo[i].pipsfactor);      
  signals[i].ratio3=MathMin((signals[i].high3-signals[i].close3)/signals[i].range3*signals[i].point3 / (-0.01),100);
  }            
  }  
  }*/
//----------------------------------------------------------------
color ColorPips1(double Pips) 
  {
  if(Pips>0)
  return (BullColor);
  if(Pips<0)
  return (BearColor);
  return (clrWhite);
  }
//----------------------------------------------------------------
color Colorstr1(double tot) 
  {
  if(tot>=trigger_buy_bidratio00)
  return (BullColor);
  if(tot<=trigger_sell_bidratio00)
  return (BearColor);
  return (clrWhite);
  }
//----------------------------------------------------------------
void swap (Pair &i, Pair &j) 
  {
  string strTemp;
  double dblTemp;
  int    intTemp;
   
  strTemp = i.symbol00; i.symbol00 = j.symbol00; j.symbol00 = strTemp;
  strTemp = i.symbol11; i.symbol11 = j.symbol11; j.symbol11 = strTemp;
  strTemp = i.symbol22; i.symbol22 = j.symbol22; j.symbol22 = strTemp;
  strTemp = i.symbol33; i.symbol33 = j.symbol33; j.symbol33 = strTemp;
  strTemp = i.symbol44; i.symbol44 = j.symbol44; j.symbol44 = strTemp;
  strTemp = i.symbol55; i.symbol55 = j.symbol55; j.symbol55 = strTemp;
  strTemp = i.symbol66; i.symbol66 = j.symbol66; j.symbol66 = strTemp;
  dblTemp = i.point00; i.point00 = j.point00; j.point00 = dblTemp;
  dblTemp = i.point11; i.point11 = j.point11; j.point11 = dblTemp;
  dblTemp = i.point22; i.point22 = j.point22; j.point22 = dblTemp;
  dblTemp = i.point33; i.point33 = j.point33; j.point33 = dblTemp;
  dblTemp = i.point44; i.point44 = j.point44; j.point44 = dblTemp;
  dblTemp = i.point55; i.point55 = j.point55; j.point55 = dblTemp;
  dblTemp = i.point66; i.point66 = j.point66; j.point66 = dblTemp;               
  dblTemp = i.open00; i.open00 = j.open00; j.open00 = dblTemp;
  dblTemp = i.open11; i.open11 = j.open11; j.open11 = dblTemp;
  dblTemp = i.open22; i.open22 = j.open22; j.open22 = dblTemp;
  dblTemp = i.open33; i.open33 = j.open33; j.open33 = dblTemp;
  dblTemp = i.open44; i.open44 = j.open44; j.open44 = dblTemp;
  dblTemp = i.open55; i.open55 = j.open55; j.open55 = dblTemp;
  dblTemp = i.open66; i.open66 = j.open66; j.open66 = dblTemp;
  dblTemp = i.close00; i.close00 = j.close00; j.close00 = dblTemp;
  dblTemp = i.close11; i.close11 = j.close11; j.close11 = dblTemp;
  dblTemp = i.close22; i.close22 = j.close22; j.close22 = dblTemp;
  dblTemp = i.close33; i.close33 = j.close33; j.close33 = dblTemp;
  dblTemp = i.close44; i.close44 = j.close44; j.close44 = dblTemp;
  dblTemp = i.close55; i.close55 = j.close55; j.close55 = dblTemp;
  dblTemp = i.close66; i.close66 = j.close66; j.close66 = dblTemp;               
  dblTemp = i.hi00; i.hi00 = j.hi00; j.hi00 = dblTemp;
  dblTemp = i.hi11; i.hi11 = j.hi11; j.hi11 = dblTemp;
  dblTemp = i.hi22; i.hi22 = j.hi22; j.hi22 = dblTemp;
  dblTemp = i.hi33; i.hi33 = j.hi33; j.hi33 = dblTemp;
  dblTemp = i.hi44; i.hi44 = j.hi44; j.hi44 = dblTemp;
  dblTemp = i.hi55; i.hi55 = j.hi55; j.hi55 = dblTemp;
  dblTemp = i.hi66; i.hi66 = j.hi66; j.hi66 = dblTemp;          
  dblTemp = i.lo00; i.lo00 = j.lo00; j.lo00 = dblTemp;
  dblTemp = i.lo11; i.lo11 = j.lo11; j.lo11 = dblTemp;
  dblTemp = i.lo22; i.lo22 = j.lo22; j.lo22 = dblTemp;
  dblTemp = i.lo33; i.lo33 = j.lo33; j.lo33 = dblTemp;
  dblTemp = i.lo44; i.lo44 = j.lo44; j.lo44 = dblTemp;
  dblTemp = i.lo55; i.lo55 = j.lo55; j.lo55 = dblTemp;
  dblTemp = i.lo66; i.lo66 = j.lo66; j.lo66 = dblTemp;                 
  dblTemp = i.ask00; i.ask00 = j.ask00; j.ask00 = dblTemp;
  dblTemp = i.ask11; i.ask11 = j.ask11; j.ask11 = dblTemp;
  dblTemp = i.ask22; i.ask22 = j.ask22; j.ask22 = dblTemp;
  dblTemp = i.ask33; i.ask33 = j.ask33; j.ask33 = dblTemp;
  dblTemp = i.ask44; i.ask44 = j.ask44; j.ask44 = dblTemp;
  dblTemp = i.ask55; i.ask55 = j.ask55; j.ask55 = dblTemp;
  dblTemp = i.ask66; i.ask66 = j.ask66; j.ask66 = dblTemp;                
  dblTemp = i.bid00; i.bid00 = j.bid00; j.bid00 = dblTemp;
  dblTemp = i.bid11; i.bid11 = j.bid11; j.bid11 = dblTemp; 
  dblTemp = i.bid22; i.bid22 = j.bid22; j.bid22 = dblTemp;
  dblTemp = i.bid33; i.bid33 = j.bid33; j.bid33 = dblTemp;
  dblTemp = i.bid44; i.bid44 = j.bid44; j.bid44 = dblTemp;
  dblTemp = i.bid55; i.bid55 = j.bid55; j.bid55 = dblTemp;
  dblTemp = i.bid66; i.bid66 = j.bid66; j.bid66 = dblTemp;               
  intTemp = i.pipsfactor00; i.pipsfactor00 = j.pipsfactor00; j.pipsfactor00 = intTemp;
  intTemp = i.pipsfactor11; i.pipsfactor11 = j.pipsfactor11; j.pipsfactor11 = intTemp;
  intTemp = i.pipsfactor22; i.pipsfactor22 = j.pipsfactor22; j.pipsfactor22 = intTemp;
  intTemp = i.pipsfactor33; i.pipsfactor33 = j.pipsfactor33; j.pipsfactor33 = intTemp;
  intTemp = i.pipsfactor44; i.pipsfactor44 = j.pipsfactor44; j.pipsfactor44 = intTemp;
  intTemp = i.pipsfactor55; i.pipsfactor55 = j.pipsfactor55; j.pipsfactor55 = intTemp;
  intTemp = i.pipsfactor66; i.pipsfactor66 = j.pipsfactor66; j.pipsfactor66 = intTemp;                
  dblTemp = i.spread00; i.spread00 = j.spread00; j.spread00 = dblTemp;
  dblTemp = i.spread11; i.spread11 = j.spread11; j.spread11 = dblTemp; 
  dblTemp = i.spread22; i.spread22 = j.spread22; j.spread22 = dblTemp;
  dblTemp = i.spread33; i.spread33 = j.spread33; j.spread33 = dblTemp;
  dblTemp = i.spread44; i.spread44 = j.spread44; j.spread44 = dblTemp;
  dblTemp = i.spread55; i.spread55 = j.spread55; j.spread55 = dblTemp;
  dblTemp = i.spread66; i.spread66 = j.spread66; j.spread66 = dblTemp;      
  dblTemp = i.pips00; i.pips00 = j.pips00; j.pips00 = dblTemp;
  dblTemp = i.pips11; i.pips11 = j.pips11; j.pips11 = dblTemp;
  dblTemp = i.pips22; i.pips22 = j.pips22; j.pips22 = dblTemp;
  dblTemp = i.pips33; i.pips33 = j.pips33; j.pips33 = dblTemp;
  dblTemp = i.pips44; i.pips44 = j.pips44; j.pips44 = dblTemp;
  dblTemp = i.pips55; i.pips55 = j.pips55; j.pips55 = dblTemp;
  dblTemp = i.pips66; i.pips66 = j.pips66; j.pips66 = dblTemp;    
  dblTemp = i.range00; i.range00 = j.range00; j.range00 = dblTemp;
  dblTemp = i.range11; i.range11 = j.range11; j.range11 = dblTemp; 
  dblTemp = i.range22; i.range22 = j.range22; j.range22 = dblTemp;
  dblTemp = i.range33; i.range33 = j.range33; j.range33 = dblTemp;
  dblTemp = i.range44; i.range44 = j.range44; j.range44 = dblTemp;
  dblTemp = i.range55; i.range55 = j.range55; j.range55 = dblTemp;
  dblTemp = i.range66; i.range66 = j.range66; j.range66 = dblTemp;  
  dblTemp = i.ratio00; i.ratio00 = j.ratio00; j.ratio00 = dblTemp;
  dblTemp = i.ratio11; i.ratio11 = j.ratio11; j.ratio11 = dblTemp;
  dblTemp = i.ratio22; i.ratio22 = j.ratio22; j.ratio22 = dblTemp;
  dblTemp = i.ratio33; i.ratio33 = j.ratio33; j.ratio33 = dblTemp;
  dblTemp = i.ratio44; i.ratio44 = j.ratio44; j.ratio44 = dblTemp;
  dblTemp = i.ratio55; i.ratio55 = j.ratio55; j.ratio55 = dblTemp;
  dblTemp = i.ratio66; i.ratio66 = j.ratio66; j.ratio66 = dblTemp;  
  dblTemp = i.calc00; i.calc00= j.calc00; j.calc00 = dblTemp;
  dblTemp = i.calc11; i.calc11= j.calc11; j.calc11 = dblTemp;
  dblTemp = i.calc22; i.calc22= j.calc22; j.calc22 = dblTemp;
  dblTemp = i.calc33; i.calc33= j.calc33; j.calc33 = dblTemp;
  dblTemp = i.calc44; i.calc44= j.calc44; j.calc44 = dblTemp;
  dblTemp = i.calc55; i.calc55= j.calc55; j.calc55 = dblTemp;
  dblTemp = i.calc66; i.calc66= j.calc66; j.calc66 = dblTemp;    
  
  }

//display 2
//----------------------------------------------------------------
void displayMeter1() {
double arrt[8][2];
   int arr2;
   arrt[0][0] = currency_strength(curr[0]); 
   arrt[1][0] = currency_strength(curr[1]);
   arrt[2][0] = currency_strength(curr[2]);
   arrt[3][0] = currency_strength(curr[3]); 
   arrt[4][0] = currency_strength(curr[4]);
   arrt[5][0] = currency_strength(curr[5]);
   arrt[6][0] = currency_strength(curr[6]);
   arrt[7][0] = currency_strength(curr[7]);
   arrt[0][1] = 0; 
   arrt[1][1] = 1; 
   arrt[2][1] = 2; 
   arrt[3][1] = 3;
   arrt[4][1] = 4; 
   arrt[5][1] = 5; 
   arrt[6][1] = 6; 
   arrt[7][1] = 7;
   ArraySort(arrt, WHOLE_ARRAY, 0, MODE_DESCEND);
   
   
   //--- GetMax
   int    maxValueIdx=ArrayMaximum(arrt,WHOLE_ARRAY,0); int Arr3 = arrt[maxValueIdx][1]; //Print(arrt[maxValueIdx][0],curr[Arr3]);
   //--- GetMin
   int    minValueIdx=ArrayMinimum(arrt,WHOLE_ARRAY,0); int Arr4 = arrt[minValueIdx][1]; //Print(arrt[maxValueIdx][0],curr[Arr4]);
   
   for (int m = 0; m < 8; m++) 
   {
   arr2 = arrt[m][1];
   //SetText(curr[arr2]+"pos",IntegerToString(m+1)+".",x_axis+670,(m*18)+y_axis+17,color_for_profit(arrt[m][0]),12);
   //SetText(curr[arr2]+"curr1", curr[arr2],(m*163)+x_axis+10,y_axis+570,clrBlack,12);
   //SetText(curr[arr2]+"currdig1", DoubleToStr(arrt[m][0],1),(m*163)+x_axis+50,y_axis+570,clrBlack,12);
   //SetPanel("Strength1"+IntegerToString(m),0,(m*163)+x_axis+5,y_axis+570,157,20,color_for_profit1(arrt[m][0]),C'61,61,61',1);                                    
   }
   ChartRedraw(); 
   }
                                
 
  //if(currstrength[m] > prevstrength[m]){SetObjText("Sdir2"+IntegerToString(m),CharToStr(217),x_axis+282,(m*15)+y_axis+234,clrDodgerBlue,8);
  //}
  //else if(currstrength[m] < prevstrength[m]){SetObjText("Sdir2"+IntegerToString(m),CharToStr(218),x_axis+282,(m*15)+y_axis+234,clrFireBrick,8);
  //}
  //else {SetObjText("Sdir2"+IntegerToString(m),CharToStr(243),x_axis+282,(m*15)+y_axis+234,clrWhite,8);
  //}

//----------------------------------------------------------------
//display 2
color color_for_profit1(double total) 
  {
  if(total<2.0)
  return (BearColor);
  if(total<=3.0)
  return (BearColor);
  if(total>7.0)
  return (BullColor);
  if(total>6.0)
  return (BullColor);
  if(total>5.0)
  return (BullColor);
  if(total<=5.0)
  return (BearColor);       
  return(clrWhite);
  }
double currency_strength1(string pair) 
  {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength = 0;
  int cnt1 = 0;
  //for (int x = 0; x < ArraySize(TradePairs); x++) {
  fact = 0;
  //sym1 = TradePairs[x];
  if (pair == StringSubstr(sym, 0, 3) || pair == StringSubstr(sym, 3, 3)) 
  {
  sym = sym + tempsym;
  range = (MarketInfo(sym, MODE_HIGH) - MarketInfo(sym, MODE_LOW)) * MarketInfo(sym, MODE_POINT);
  if (range != 0.0) 
  {
  ratio = 100.0 * ((MarketInfo(sym, MODE_BID) - MarketInfo(sym, MODE_LOW)) / range * MarketInfo(sym, MODE_POINT));
  if (ratio > 3.0) fact = 1;
  if (ratio > 10.0) fact = 2;
  if (ratio > 25.0) fact = 3;
  if (ratio > 40.0) fact = 4;
  if (ratio > 50.0) fact = 5;
  if (ratio > 60.0) fact = 6;
  if (ratio > 75.0) fact = 7;
  if (ratio > 90.0) fact = 8;
  if (ratio > 97.0) fact = 9;
  cnt1++;
  if (pair == StringSubstr(sym, 3, 3)) fact = 9 - fact;
  strength += fact;
  }
  }      
  //}
  if(cnt1!=0)strength /= cnt1;
  return (strength);
  }
//----------------------------------------------------------------
double old_currency_strength1(string pair) 
  {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength=0;
  int cnt1=0;
  
  for(int x=0; x<ArraySize(TradePairs); 
  x++) 
  {
  fact= 0;
  sym = TradePairs[x];
  int bar = iBarShift(TradePairs[x],PERIOD_M1,TimeCurrent()-432000);
  double prevbid = iClose(TradePairs[x],PERIOD_M1,bar);
  
  if(pair==StringSubstr(sym,0,3) || pair==StringSubstr(sym,3,3)) 
  {
  // sym = sym + tempsym;
  range=(MarketInfo(sym,MODE_HIGH)-MarketInfo(sym,MODE_LOW));
  if(range!=0.0) 
  {
  ratio=100.0 *((prevbid-MarketInfo(sym,MODE_LOW))/range);
  
  if(ratio > 3.0)  fact = 1;
  if(ratio > 10.0) fact = 2;
  if(ratio > 25.0) fact = 3;
  if(ratio > 40.0) fact = 4;
  if(ratio > 50.0) fact = 5;
  if(ratio > 60.0) fact = 6;
  if(ratio > 75.0) fact = 7;
  if(ratio > 90.0) fact = 8;
  if(ratio > 97.0) fact = 9;
  
  cnt1++;
  if(pair==StringSubstr(sym,3,3))
  fact= 9-fact;
  strength+=fact;
  }
  }
  }
  if(cnt1!=0)
  strength/=cnt1;
  return (strength);
} 

//----------------------------------------------------------------
color Colorsync00(double tot) 
  {
  if(tot>=trigger_buy_relstrength00)
  return (BullColor);
  if(tot<=trigger_sell_relstrength00)
  return (BearColor);
  return (clrWhite);
  }
//----------------------------------------------------------------
color Colorsync11(double tot) 
  {
  if(tot>=trigger_buy_relstrength11)
  return (BullColor);
  if(tot<=trigger_sell_relstrength11)
  return (BearColor);
  return (clrWhite);
  }
//----------------------------------------------------------------
color Colorsync22(double tot) 
  {
  if(tot>=trigger_buy_relstrength22)
  return (BullColor);
  if(tot<=trigger_sell_relstrength22)
  return (BearColor);
  return (clrWhite);
  }
//----------------------------------------------------------------
color Colorsync33(double tot) 
  {
  if(tot>=trigger_buy_relstrength33)
  return (BullColor);
  if(tot<=trigger_sell_relstrength33)
  return (BearColor);
  return (clrWhite);
  }
//----------------------------------------------------------------
color Colorsync44(double tot) 
  {
  if(tot>=trigger_buy_relstrength44)
  return (BullColor);
  if(tot<=trigger_sell_relstrength44)
  return (BearColor);
  return (clrWhite);
  }
//----------------------------------------------------------------
color Colorsync55(double tot) 
  {
  if(tot>=trigger_buy_relstrength55)
  return (BullColor);
  if(tot<=trigger_sell_relstrength55)
  return (BearColor);
  return (clrWhite);
  }
//----------------------------------------------------------------
color Colorsync66(double tot) 
  {
  if(tot>=trigger_buy_relstrength66)
  return (BullColor);
  if(tot<=trigger_sell_relstrength66)
  return (BearColor);
  return (clrWhite);
  }            
//----------------------------------------------------------------
//======================RUN=974=============== 

void GetTrendChange() 
{
  for (int i=0;i<ArraySize(TradePairs);i++) 
  {
  signals[i].Signalcci = NONE;
  double cci = iCCI(TradePairs[i],0, 21, PRICE_CLOSE, Current + 1);
  double CloseBuy1_1 =  cci ;
  double CloseBuy1_2 = 100;
  double CloseSell1_1 =  cci ;
  double CloseSell1_2 = -100;   
  if (CloseBuy1_1 > CloseBuy1_2)  
  {        
  signals[i].Signalcci = UP;
  } 
  if (CloseSell1_1 < CloseSell1_2) 
  {        
  signals[i].Signalcci = DOWN;
  }      
  }
  }
 //======================RUN=974=============== 
 void GetCciSignals(int i)
 {
  cci_00 = iCCI(TradePairs[i],0, 21, PRICE_CLOSE, 0);     
  cci_01 = iCCI(TradePairs[i],0, 21, PRICE_CLOSE, 1);            
  color MyColor;
  if(signals[i].Signalcci==UP && MyColor != clrNONE)  
  {
  //SetObjText("CCI"+IntegerToString(i),CharToStr(225),x_axis+480,(i*12)+y_axis+235,clrBlack,8);
  }
  if(signals[i].Signalcci==DOWN && MyColor != clrNONE)
  {
  //SetObjText("CCI"+IntegerToString(i),CharToStr(226),x_axis+480,(i*12)+y_axis+235,clrBlack,8);
  }   
  }
///////////////////////////////////////////////////////////////////////////////// 
//------------------------   PlSoft ROUTINE  ------------------------------------ 
/////////////////////////////////////////////////////////////////////////////////
string t[12],x[12],opt[12];
sinput double    Min_Profit      = 300.0;
double goal                      = Min_Profit;
int ATRTimeFrame= PERIOD_D1;        // timeframe for ATR (LEAVE AT PERIOD_D1)
int ATRPeriod= 15;           // period for ATR
int CciValue = 30;
double cci_00,cci_01;

//==========================================================================================
 string ___BBands= "-------------------------";
enum  yesnoChoiceToggle{No,Yes};   
 yesnoChoiceToggle useBollingerBands=Yes;//Use BollingerBands upper/lower Filter
 ENUM_TIMEFRAMES BBtimeFrame=PERIOD_M30;//Bollinger Bands: Timeframe
 int BBperiod=20;//Bollinger Bands: Period
 double BBdeviation=2;//Bollinger Bands: Deviations
 int BBShift=0;//Bollinger Bands: Shift
 ENUM_APPLIED_PRICE BBAppliedPrice=PRICE_CLOSE;//Bollinger Bands: Apply to

//=========================================================================================
 string ___DaySearch= "-------------------------";
 bool DebugLogger = false;
 int TimeZoneOfData= 0;       // fuso horário gráfico (de GMT)
 bool UseManualADR= false;    // permite o uso de valor manual para intervalo
 int ManualADRValuePips= 0;   // valor manual para intervalo
 int TimeZoneOfSession= -1; 

extern bool   alertsMessage      = false;
extern bool   alertsNotification = false;
static datetime previousTime[28][3];                  // alert floor

input int    MinStep     = 25;      //Points to Hedge (Ex: 25 MinStep + 25 MinStepPlus = 50 pontos)
input int    MinStepPlus = 25;      //
//------------------------ VALORI HIGH LOW ADR ---------------------------------- 
/////////////////////////////////////////////////////////////////////////////////
double GetAverageRangeHigh(string symbolName)
//+------------------------------------------------------------------+
  {
  double todayHigh=iHigh(symbolName,ATRTimeFrame,0);
  double todayLow=iLow(symbolName,ATRTimeFrame,0);
  double rangeHigh=GetTimeFrameLowestLow(symbolName)+GetAverageRangeNumPeriods(symbolName);
  double averageRange=GetAverageRangeNumPeriods(symbolName);
  if(todayHigh - todayLow > averageRange)
  {
  if(MarketInfo(symbolName,MODE_BID) >= todayHigh- (todayHigh-todayLow)/2)
  {
  rangeHigh = todayLow + averageRange; 
  }
  else
  {
  rangeHigh  = todayHigh;        
  }
  }
  return rangeHigh;
  }
//+------------------------------------------------------------------+
double GetAverageRangeLow(string symbolName)
//+------------------------------------------------------------------+
  {
  double todayHigh=iHigh(symbolName,ATRTimeFrame,0);
  double todayLow=iLow(symbolName,ATRTimeFrame,0);
  double rangeLow=GetTimeFrameHighestHigh(symbolName)-GetAverageRangeNumPeriods(symbolName);
  double averageRange=GetAverageRangeNumPeriods(symbolName);
  
  if(todayHigh - todayLow > averageRange)
  {
  if(MarketInfo(symbolName,MODE_BID) >= todayHigh- (todayHigh-todayLow)/2)
  {
  rangeLow  = todayLow;         
  }
  else
  {
  rangeLow = todayHigh - averageRange;         
  }
  }     
  return rangeLow;
  }  
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double GetTimeFrameHighestHigh(string symbolName)
//+------------------------------------------------------------------+
  {
  return iHigh(symbolName,ATRTimeFrame,0);
  }  
//+------------------------------------------------------------------+
double GetTimeFrameLowestLow(string symbolName)
//+------------------------------------------------------------------+
  {
  return iLow(symbolName,ATRTimeFrame,0);
  }  
//+------------------------------------------------------------------+
double GetAverageRangeNumPeriods(string symbolName)
//+------------------------------------------------------------------+
  {
  double result=0;
  double averageRange=0;
  for(int i=1; i<=ATRPeriod; i++)
  {
  double high=iHigh(symbolName,ATRTimeFrame,i);
  double low=iLow(symbolName,ATRTimeFrame,i);
  averageRange+=high-low;
  }
  return result=averageRange/ATRPeriod;
  }
//+------------------------------------------------------------------+  
int NewTracePivot(double alto,double basso, int i,int candela,color clStato)
//+------------------------------------------------------------------+
  {
  int T, opT; 
  double Op       = iOpen (TradePairs[i], PERIOD_D1, 0);
  double Price    = iClose(TradePairs[i], PERIOD_D1, candela);
  double Minimo   = iLow  (TradePairs[i], PERIOD_M30, candela+1);
  double Massimo  = iHigh (TradePairs[i], PERIOD_D1, candela+1);                              
   
  double adr_00,adr_01,adr_02,adr_03,adr_04,adr_05,adr_06,adr_07,adr_08,adr_09,adr_10;
  
  if(TradePairs[i]!=_Symbol){
  adr_10 = GetAverageRangeHigh(TradePairs[i]);  
  adr_09 = GetAverageRangeLow(TradePairs[i]) + ((GetAverageRangeHigh(TradePairs[i])-GetAverageRangeLow(TradePairs[i]))/10*9);
  adr_08 = GetAverageRangeLow(TradePairs[i]) + ((GetAverageRangeHigh(TradePairs[i])-GetAverageRangeLow(TradePairs[i]))/10*8);               
  adr_07 = GetAverageRangeLow(TradePairs[i]) + ((GetAverageRangeHigh(TradePairs[i])-GetAverageRangeLow(TradePairs[i]))/10*7);
  adr_06 = GetAverageRangeLow(TradePairs[i]) + ((GetAverageRangeHigh(TradePairs[i])-GetAverageRangeLow(TradePairs[i]))/10*6);
  adr_05 = GetAverageRangeLow(TradePairs[i]) + ((GetAverageRangeHigh(TradePairs[i])-GetAverageRangeLow(TradePairs[i]))/10*5);
  adr_04 = GetAverageRangeLow(TradePairs[i]) + ((GetAverageRangeHigh(TradePairs[i])-GetAverageRangeLow(TradePairs[i]))/10*4);
  adr_03 = GetAverageRangeLow(TradePairs[i]) + ((GetAverageRangeHigh(TradePairs[i])-GetAverageRangeLow(TradePairs[i]))/10*3);      
  adr_02 = GetAverageRangeLow(TradePairs[i]) + ((GetAverageRangeHigh(TradePairs[i])-GetAverageRangeLow(TradePairs[i]))/10*2);
  adr_01 = GetAverageRangeLow(TradePairs[i]) + ((GetAverageRangeHigh(TradePairs[i])-GetAverageRangeLow(TradePairs[i]))/10*1);
  adr_00 = GetAverageRangeLow(TradePairs[i]) ; }else{
  
  adr_10 = alto;  
  adr_09 = basso + ((alto-basso)/10*9);
  adr_08 = basso + ((alto-basso)/10*8);               
  adr_07 = basso + ((alto-basso)/10*7);
  adr_06 = basso + ((alto-basso)/10*6);
  adr_05 = basso + ((alto-basso)/10*5);
  adr_04 = basso + ((alto-basso)/10*4);
  adr_03 = basso + ((alto-basso)/10*3);      
  adr_02 = basso + ((alto-basso)/10*2);
  adr_01 = basso + ((alto-basso)/10*1);
  adr_00 = basso ;    
  }
  
  color MyColor = clrRed; int freccia=225;
  if(GetAverageRangeHigh(TradePairs[i])-iOpen(TradePairs[i], PERIOD_D1,0)>iOpen(TradePairs[i], PERIOD_D1,0)-GetAverageRangeLow(TradePairs[i]))
  { MyColor = clrLime; freccia = 226;} 
    
  ObjectSet("Ctrand"+IntegerToString(i), OBJPROP_COLOR,MyColor); 	                  // cambio di colore }  
         
  if (Price>adr_10)  {t[10] = "above 10 ";T=10;}          
  else if (Price>adr_09)  {t[9]  = "above 09 ";T=9;}  
  else if (Price>adr_08)  {t[8]  = "above 08 ";T=8;}
  else if (Price>adr_07)  {t[7]  = "above 07 ";T=7;}
  else if (Price>adr_06)  {t[6]  = "above 06 ";T=6;}
  else if (Price>adr_05)  {t[5]  = "above 05 ";T=5;}
  else if (Price>adr_04)  {t[4]  = "above 04 ";T=4;}
  else if (Price>adr_03)  {t[3]  = "above 03 ";T=3;}
  else if (Price>adr_02)  {t[2]  = "above 02 ";T=2;}
  else if (Price>adr_01)  {t[1]  = "above 01 ";T=1;}
  else if (Price>adr_00)  {t[0]  = "above 00 ";T=0;}   
  else                    {t[11] = "below pivot"; T=11;}  
  
//---          
  MyColor = C'61,61,61'; string sign;
  
  if( Minimo <adr_03  && Price>adr_03 ) { MyColor=BullColor; sign = "Buy ";}
  else 
  if( Massimo>adr_07  && Price<adr_07 ) { MyColor=BearColor; sign = "Sell";} 
  
  SetObjText("AdrSig"+IntegerToString(i),CharToStr(139+T),c_axis+430,(i*12)+cc_axis+234,MyColor,8);    

//---   
  
  if (Op>adr_10)  {opt[10] = "above 10 ";opT=10;}          
  else if (Op>adr_09)  {opt[9]  = "above 09 ";opT=9;}  
  else if (Op>adr_08)  {opt[8]  = "above 08 ";opT=8;}
  else if (Op>adr_07)  {opt[7]  = "above 07 ";opT=7;}
  else if (Op>adr_06)  {opt[6]  = "above 06 ";opT=6;}
  else if (Op>adr_05)  {opt[5]  = "above 05 ";opT=5;}
  else if (Op>adr_04)  {opt[4]  = "above 04 ";opT=4;}
  else if (Op>adr_03)  {opt[3]  = "above 03 ";opT=3;}
  else if (Op>adr_02)  {opt[2]  = "above 02 ";opT=2;}
  else if (Op>adr_01)  {opt[1]  = "above 01 ";opT=1;}
  else if (Op>adr_00)  {opt[0]  = "above 00 ";opT=0;}   
  else                    {opt[11] = "below pivot"; opT=0;}   
               
  MyColor = C'61,61,61';
   
        if( Op<adr_03 ) { MyColor=BullColor; }
  else if( Op>adr_07 ) { MyColor=BearColor; } 
  
  SetObjText("OpTrend"+IntegerToString(i),CharToStr(139+opT),c_axis+420,(i*12)+cc_axis+234,MyColor,8);

//---
            
  if(ColorBSRat(signals[i].strength5)==MyColor)
  { 
  SetPanel("ADR12"+IntegerToString(i),0,c_axis+430,(i*12)+cc_axis+234,10,8,MyColor,C'61,61,61',1); 
  if(previousTime[i][2]<Time[0]){ doAlert(i,"LEVEL",sign,t[T]); 
  }
  }    

  MyColor = clrBlack; sign = "Sell"; 
  if(ColorBSRat(signals[i].strength5)==ObjectGet("Ctrand"+IntegerToString(i),OBJPROP_COLOR)) 
  { 
  if(ColorBSRat(signals[i].strength5)==BullColor) { sign = "Buy"; 
  }
  MyColor = clrNavy; if(previousTime[i][1]<Time[0]){ doAlert(i,"FENIX",sign,opt[T]);
  
  string matrix= IntegerToString(0)+","+IntegerToString(DaySearch())+","+IntegerToString(i);  //adr  
  ObjectSet(matrix, OBJPROP_COLOR,ObjectGet("Ctrand"+IntegerToString(i),OBJPROP_COLOR));   
  }
  }   
  
  ColorPanel("BSRatio"+IntegerToString(i),MyColor,C'61,61,61');       
 //ColorPanel("PrevGAP"+IntegerToString(i),MyColor,C'61,61,61'); 
  
  return(T);   
  } 
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|CLOCK                                                             |
//+------------------------------------------------------------------+ 
string clock() {
//+------------------------------------------------------------------+           
  int li_8 = Time[0] + 60 * Period() - TimeCurrent();
  double ld_0 = li_8 / 60.0;
  int li_12 = li_8 % 60;
  li_8 = (li_8 - li_8 % 60) / 60;
  
  string clock = IntegerToString(li_8) + " minutes " + IntegerToString(li_12) + " to "+DaySearch();
  SetText("clock",clock ,x_axis+5,y_axis+75,clrGold,8); 
  return(clock);
  } 
//+------------------------------------------------------------------+
int isUpperLowerBollinger(int i)
//+------------------------------------------------------------------+
  {
  pairinfo[i].Bb=0;
  double symbolBidPrice=SymbolInfoDouble(TradePairs[i],SYMBOL_BID);
//gets the  current upper/lower bands values of selected symbol and bollinger parameters
  double upperBand=iBands(TradePairs[i],BBtimeFrame,BBperiod,BBdeviation,BBShift,BBAppliedPrice,1,0);
  double lowerBand=iBands(TradePairs[i],BBtimeFrame,BBperiod,BBdeviation,BBShift,BBAppliedPrice,2,0);
  if(symbolBidPrice>upperBand){pairinfo[i].Bb= 1;}
  if(symbolBidPrice<lowerBand){pairinfo[i].Bb=-1;}
  
  return (pairinfo[i].Bb);
  }    
//+------------------------------------------------------------------+
void  GetMatrix(int matrice, int posx, int posy, int largo, int passo, int altezza, color cl)
//+------------------------------------------------------------------+
{         
  
  string matrix;                       
  
  for(int xi=23; xi >= 0; xi--)       //candle 
  {          
  for(int xx=27; xx >= 0; xx--)   //bollinger 
  {             
  matrix= IntegerToString(matrice)+","+IntegerToString(xi)+","+IntegerToString(xx);    
  SetObjText(matrix,CharToStr(110),posx+(xi*(largo)),(xx*passo)+posy*1,cl,altezza);
  }  
  }                                                                                                                                                                                                                                                                                                                       
  }  
//+------------------------------------------------------------------+
//| Day Search                                                       |
//+------------------------------------------------------------------+
int DaySearch()
{
  static datetime timelastupdate= 0;
  static int lasttimeframe= 0,
              lastfirstbar= -1;
   
  int idxfirstbaroftoday= 0,
       idxfirstbarofyesterday= 0,
       idxlastbarofyesterday= 0;
   //---- exit if period is greater than daily charts
  if(Period() > 1440) 
  {
  Alert("Error - Chart period is greater than 1 day.");
  return(-1); // then exit
  }
  
  if (DebugLogger) 
  {
  Print("Local time current bar:", TimeToStr(Time[0]));
  Print("Dest  time current bar: ", TimeToStr(Time[0]- (TimeZoneOfData - TimeZoneOfSession)*3600), ", tzdiff= ", TimeZoneOfData - TimeZoneOfSession);
  }

  // let's find out which hour bars make today and yesterday
  ComputeDayIndices(TimeZoneOfData, TimeZoneOfSession, idxfirstbaroftoday, idxfirstbarofyesterday, idxlastbarofyesterday);

  // no need to update these buggers too often (the code below is a bit tricky, usually just the 
  // timelastupdate would be sufficient, but when turning on MT after the night there is just
  // the newest bar while the rest of the day is missing and updated a bit later).  Don't mess
  // with this unless you are absolutely sure you know what you're doing.
  if (Time[0]==timelastupdate && Period()==lasttimeframe && lastfirstbar==idxfirstbaroftoday) 
  {
  //    return (0);
  }
      
  lasttimeframe= Period();
  timelastupdate= Time[0];
  lastfirstbar= idxfirstbaroftoday;         
   //
   // okay, now we know where the days start and end
   //  
  int tzdiff= TimeZoneOfData + TimeZoneOfSession,
       tzdiffsec= tzdiff*3600;
  
  datetime startofday= Time[idxfirstbaroftoday];  // datetime (x-value) for labes on horizontal bars   
  // draw the vertical bars that marks the time span
  //SetTimeLine("today start", "Start", idxfirstbaroftoday, CadetBlue, Low[idxfirstbaroftoday]- 10*Point);   
  //Print("Candela n° " + iOpen("EURUSD",0,idxfirstbaroftoday));
  return(idxfirstbaroftoday);
  }
//+------------------------------------------------------------------+
//| Compute index of first/last bar of yesterday and today           |
//+------------------------------------------------------------------+
void ComputeDayIndices(int tzlocal, int tzdest, int &idxfirstbaroftoday, int &idxfirstbarofyesterday, int &idxlastbarofyesterday)
  {     
  int tzdiff= tzlocal + tzdest,
      tzdiffsec= tzdiff*3600,
      dayminutes= 24 * 60,
      barsperday= dayminutes/Period();
  
  int dayofweektoday= TimeDayOfWeek(Time[0] - tzdiffsec),  // what day is today in the dest timezone?
      dayofweektofind= -1; 

   //
   // due to gaps in the data, and shift of time around weekends (due 
   // to time zone) it is not as easy as to just look back for a bar 
   // with 00:00 time
   //
   
  idxfirstbaroftoday= 0;
  idxfirstbarofyesterday= 0;
  idxlastbarofyesterday= 0;
       
  switch (dayofweektoday) {
     case 6: // sat
     case 0: // sun
     case 1: // mon
     dayofweektofind= 5; // yesterday in terms of trading was previous friday
     break;
            
     default:
     dayofweektofind= dayofweektoday -1; 
     break;
   }
   
  if (DebugLogger) {
  Print("Dayofweektoday= ", dayofweektoday);
  Print("Dayofweekyesterday= ", dayofweektofind);
  }
  // search  backwards for the last occrrence (backwards) of the day today (today's first bar)
  for (int i= 0; i<=barsperday+1; i++) {
  datetime timet= Time[i] - tzdiffsec;
  // Print(Symbol(), " DayofWeek[", i, ,"]= ", TimeDayOfWeek(timet), " (", dayofweektoday, ") ", TimeToStr(timet));
  if (TimeDayOfWeek(timet)!=dayofweektoday) {
  idxfirstbaroftoday= i-1;
  break;
  }
  }
  // Print(Symbol(), " idxfirstoftoday ", idxfirstbaroftoday);
  
   int xi=0;
   
   // search  backwards for the first occrrence (backwards) of the weekday we are looking for (yesterday's last bar)
   for (int xj= 0; xj<=2*barsperday+1; xj++) {
   datetime timey= Time[xi+xj] - tzdiffsec;
   if (TimeDayOfWeek(timey)==dayofweektofind) {  // ignore saturdays (a Sa may happen due to TZ conversion)
   idxlastbarofyesterday= xi+xj;
   break;
   }
   }
   
   // search  backwards for the first occurrence of weekday before yesterday (to determine yesterday's first bar)
   for (int j= 1; j<=barsperday; j++) {
   datetime timey2= Time[idxlastbarofyesterday+j] - tzdiffsec;
   if (TimeDayOfWeek(timey2)!=dayofweektofind) {  // ignore saturdays (a Sa may happen due to TZ conversion)
   idxfirstbarofyesterday= idxlastbarofyesterday+j-1;
   break;
   }      
   }

   if (DebugLogger) {
   Print("Dest time zone\'s current day starts:", TimeToStr(Time[idxfirstbaroftoday]), 
   " (local time), idxbar= ", idxfirstbaroftoday);
   
   Print("Dest time zone\'s previous day starts:", TimeToStr(Time[idxfirstbarofyesterday]), 
   " (local time), idxbar= ", idxfirstbarofyesterday);
   Print("Dest time zone\'s previous day ends:", TimeToStr(Time[idxlastbarofyesterday]), 
   " (local time), idxbar= ", idxlastbarofyesterday);
   }
   } 
//+------------------------------------------------------------------+
void doAlert(int i, string doWhat, string PivotName, string OP)
//+------------------------------------------------------------------+
   {                       
   string message=""; 
   string Bb = "";
   
   if(pairinfo[i].Bb== 1)  Bb = "Bull";
   else if(pairinfo[i].Bb== -1) Bb = "Bear";
   else                                   Bb = "Null";
   
   message= StringConcatenate(     TradePairs[i]
                            ," ",     PivotName
                            ," ADR: ", doWhat 
                            ," Bb: ", Bb  
                            ," Price: "  , DoubleToString(iClose(TradePairs[i], PERIOD_D1, 0),4)                                                  
                            ," Pvt: ",OP 
                            );
                  
   if (DaySearch()>=2 && alertsMessage) SendNotification(message);
   
   message= StringConcatenate(     TradePairs[i]
                            ," ",     PivotName
                            //," ",     TimeToStr(TimeLocal(),TIME_SECONDS)
                            ," ADR: ", doWhat 
                            ," Bb: ", Bb   
                            ," Price: " ,  DoubleToString(iClose(TradePairs[i], PERIOD_D1, 0),4) 
                            ," Pvt: ",OP                                                  
                            );
                                     
   if (DaySearch()>=2 && alertsNotification) Alert(message);
   
   previousTime[i][1] = Time[0];  
   previousTime[i][2] = Time[0]; 
   
   //plsoft_WriteFile(TradePairs[i],message);                  
   
   } 
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+  
void SetEditLabel( string label_Name,
                   int label_X,
                   int label_Y,
                   int width,
                   int height,
                   string label_Text,
                   int font,
                   color colir_but,
                   color colir_bg,
                   string tip
                 )
{

if(ObjectFind(label_Name)<0) ObjectCreate(0,label_Name,OBJ_EDIT,0,0,0);
      ObjectSetInteger(0,label_Name,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
      ObjectSetInteger(0,label_Name,OBJPROP_XDISTANCE,label_X);
      ObjectSetInteger(0,label_Name,OBJPROP_YDISTANCE,label_Y);
      ObjectSetInteger(0,label_Name,OBJPROP_XSIZE,width);
      ObjectSetInteger(0,label_Name,OBJPROP_YSIZE,height);
      ObjectSetString(0,label_Name,OBJPROP_TEXT,label_Text);
      ObjectSetInteger(0,label_Name,OBJPROP_SELECTABLE,false);
      ObjectSetInteger(0,label_Name,OBJPROP_BACK,false); 
      ObjectSetString(0,label_Name,OBJPROP_TOOLTIP,tip);
      ObjectSetInteger(0,label_Name,OBJPROP_FONTSIZE,font);
      ObjectSetInteger(0,label_Name,OBJPROP_COLOR,colir_but);
      ObjectSetInteger(0,label_Name,OBJPROP_BGCOLOR,colir_bg);
      ObjectSetInteger(0,label_Name,OBJPROP_ZORDER,11);
      
      ObjectSetInteger(0,label_Name,OBJPROP_ALIGN,ALIGN_CENTER);
      ObjectSetInteger(0,label_Name,OBJPROP_BORDER_COLOR,clrGreen);
}   
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//======================CCI===============01 
void GetCommodity() 
  {
  for (int i=0;i<ArraySize(TradePairs);i++) {
  signals[i].Signalcci = NONE;
  double cci = iCCI(TradePairs[i],0, trade_Period_CCI1, PRICE_WEIGHTED, periodCCI1);
  double CloseBuy1_1 =  cci ;
  double CloseBuy1_21 = -0;
  double CloseSell1_1 =  cci ;
  double CloseSell1_21 = 0;   
  if (CloseBuy1_1 < CloseBuy1_21)  
  {        
  signals[i].Signalcciup1 = UP;
  } 
  if (CloseSell1_1 > CloseSell1_21) 
  {        
  signals[i].Signalccidn1 = DOWN;
  } 
//======================CCI===============02 
//void GetCommodity2() {
  for (int i=0;i<ArraySize(TradePairs);i++) 
  {
  signals[i].Signalcci = NONE;
  double cci = iCCI(TradePairs[i],0, trade_Period_CCI2, PRICE_WEIGHTED, periodCCI2);
  double CloseBuy1_1 =  cci ;
  double CloseBuy1_22 = -0;
  double CloseSell1_1 =  cci ;
  double CloseSell1_22 = 0;   
  if (CloseBuy1_1 < CloseBuy1_22)  
  {        
  signals[i].Signalcciup2 = UP;
  } 
  if (CloseSell1_1 > CloseSell1_22) 
  {        
  signals[i].Signalccidn2 = DOWN;
  }      
//======================CCI===============02 
//void GetCommodity3() {
  for (int i=0;i<ArraySize(TradePairs);i++)
  {
  signals[i].Signalcci = NONE;
  double cci = iCCI(TradePairs[i],0, trade_Period_CCI3, PRICE_WEIGHTED, periodCCI3);
  double CloseBuy1_1 =  cci ;
  double CloseBuy1_23 = -0;
  double CloseSell1_1 =  cci ;
  double CloseSell1_23 = 0;   
  if (CloseBuy1_1 < CloseBuy1_23)  
  {        
  signals[i].Signalcciup3 = UP;
  } 
  if (CloseSell1_1 > CloseSell1_23) 
  {        
  signals[i].Signalccidn3 = DOWN;
  }      
  }
  }   
//======================MACD===============01 
//int OnInit(void)
  {
  IndicatorDigits(Digits+1);
//--- drawing settings
  SetIndexStyle(0,DRAW_HISTOGRAM);
  SetIndexStyle(1,DRAW_LINE);
  SetIndexDrawBegin(1,SignPeriod);
//--- indicator buffers mapping
  SetIndexBuffer(0,ExtMacdBuffer);
  SetIndexBuffer(1,ExtSignalBuffer);
//--- name for DataWindow and indicator subwindow label
  IndicatorShortName("MACD("+IntegerToString(FastPeriod)+","+IntegerToString(SlowPeriod)+","+IntegerToString(SignPeriod)+")");
  SetIndexLabel(0,"MACD");
  SetIndexLabel(1,"Signal");
//--- check for input parameters
  if(FastPeriod<=1 || SlowPeriod<=1 || SignPeriod<=1 || FastPeriod>=SlowPeriod)
  {
  Print("Wrong input parameters");
  ExtParameters=false;
//return(INIT_FAILED);
  }
  else
  ExtParameters=false;
//--- initialization done
//return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Moving Averages Convergence/Divergence                           |
//+------------------------------------------------------------------+
/*int OnCalculate (const int rates_total,
  const int prev_calculated,
  const datetime& time[],
  const double& open[],
  const double& high[],
  const double& low[],
  const double& close[],
  const long& tick_volume[],
  const long& volume[],
  const int& spread[])
  {
  int i,limit;
//---
  if(rates_total<=InpSignalSMA || !ExtParameters)
  return(0);
//--- last counted bar will be recounted
  limit=rates_total-prev_calculated;
  if(prev_calculated>0)
  //limit++;
//--- macd counted in the 1-st buffer
  for(i=0; i<limit; i++)
  ExtMacdBuffer[i]=iMA(NULL,0,InpFastEMA,0,MODE_EMA,PRICE_CLOSE,i)-
  iMA(NULL,0,InpSlowEMA,0,MODE_EMA,PRICE_CLOSE,i);
//--- signal line counted in the 2-nd buffer
  SimpleMAOnBuffer(rates_total,prev_calculated,0,InpSignalSMA,ExtMacdBuffer,ExtSignalBuffer);
//--- done
  return(rates_total);
  }*/
//======================MACD===============02 
  double valuem = iMACD(TradePairs[i],periodMACD1,FastPeriod,SlowPeriod,SignPeriod,Price,MODE_MAIN  ,0); //Times[t] no lugar no period
  double values = iMACD(TradePairs[i],periodMACD1,FastPeriod,SlowPeriod,SignPeriod,Price,MODE_SIGNAL,0);
  if (valuem > 0)
  if (valuem > values) 
  signals[i].SignalMACDup01=UP;
  if (valuem < 0)
  if (valuem < values) 
  signals[i].SignalMACDdn01=DOWN; 
  /*signals[i].SignalMACDup=(signals[i].Signalham12==UP&&signals[i].Signalham52==UP);
  signals[i].SignalMACDdn=(signals[i].Signalham12==DOWN&&signals[i].Signalham52==DOWN);*/               
//MACD
//MACD1
//int OnInit(void)
  {
  IndicatorDigits(Digits+1);
//--- drawing settings
  SetIndexStyle(0,DRAW_HISTOGRAM);
  SetIndexStyle(1,DRAW_LINE);
  SetIndexDrawBegin(1,SignPeriod1);
//--- indicator buffers mapping
  SetIndexBuffer(0,ExtMacdBuffer1);
  SetIndexBuffer(1,ExtSignalBuffer1);
//--- name for DataWindow and indicator subwindow label
  IndicatorShortName("MACD("+IntegerToString(FastPeriod1)+","+IntegerToString(SlowPeriod1)+","+IntegerToString(SignPeriod1)+")");
  SetIndexLabel(0,"MACD");
  SetIndexLabel(1,"Signal");
//--- check for input parameters
  if(FastPeriod1<=1 || SlowPeriod1<=1 || SignPeriod1<=1 || FastPeriod1>=SlowPeriod1)
  {
  Print("Wrong input parameters");
  ExtParameters1=false;
  //return(INIT_FAILED);
  }
  else
  ExtParameters1=false;
//--- initialization done
  //return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Moving Averages Convergence/Divergence                           |
//+------------------------------------------------------------------+
/*int OnCalculate (const int rates_total,
  const int prev_calculated,
  const datetime& time[],
  const double& open[],
  const double& high[],
  const double& low[],
  const double& close[],
  const long& tick_volume[],
  const long& volume[],
  const int& spread[])
  {
  int i,limit;
//---
  if(rates_total<=InpSignalSMA || !ExtParameters)
  return(0);
//--- last counted bar will be recounted
  limit=rates_total-prev_calculated;
  if(prev_calculated>0)
  //limit++;
//--- macd counted in the 1-st buffer
  for(i=0; i<limit; i++)
  ExtMacdBuffer[i]=iMA(NULL,0,InpFastEMA,0,MODE_EMA,PRICE_CLOSE,i)-
  iMA(NULL,0,InpSlowEMA,0,MODE_EMA,PRICE_CLOSE,i);
//--- signal line counted in the 2-nd buffer
  SimpleMAOnBuffer(rates_total,prev_calculated,0,InpSignalSMA,ExtMacdBuffer,ExtSignalBuffer);
//--- done
  return(rates_total);
  }*/
//======================MACD===============03 
  double valuem1 = iMACD(TradePairs[i],periodMACD2,FastPeriod1,SlowPeriod1,SignPeriod1,Price,MODE_MAIN  ,0); //Times[t] no lugar no period
  double values1 = iMACD(TradePairs[i],periodMACD2,FastPeriod1,SlowPeriod1,SignPeriod1,Price,MODE_SIGNAL,0);
  if (valuem1 > 0)
  if (valuem1 > values1) 
  signals[i].SignalMACDup02=UP;
  if (valuem1 < 0)
  if (valuem1 < values1) 
  signals[i].SignalMACDdn02=DOWN; 
  /*signals[i].SignalMACDup=(signals[i].Signalham12==UP&&signals[i].Signalham52==UP);
  signals[i].SignalMACDdn=(signals[i].Signalham12==DOWN&&signals[i].Signalham52==DOWN);*/               
//MACD
//MACD2
//int OnInit(void)
  {
  IndicatorDigits(Digits+1);
//--- drawing settings
  SetIndexStyle(0,DRAW_HISTOGRAM);
  SetIndexStyle(1,DRAW_LINE);
  SetIndexDrawBegin(1,SignPeriod2);
//--- indicator buffers mapping
  SetIndexBuffer(0,ExtMacdBuffer2);
  SetIndexBuffer(1,ExtSignalBuffer2);
//--- name for DataWindow and indicator subwindow label
  IndicatorShortName("MACD("+IntegerToString(FastPeriod2)+","+IntegerToString(SlowPeriod2)+","+IntegerToString(SignPeriod2)+")");
  SetIndexLabel(0,"MACD");
  SetIndexLabel(1,"Signal");
//--- check for input parameters
  if(FastPeriod2<=1 || SlowPeriod2<=1 || SignPeriod2<=1 || FastPeriod2>=SlowPeriod2)
  {
  Print("Wrong input parameters");
  ExtParameters2=false;
  //return(INIT_FAILED);
  }
  else
  ExtParameters2=false;
//--- initialization done
  //return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Moving Averages Convergence/Divergence                           |
//+------------------------------------------------------------------+
/*int OnCalculate (const int rates_total,
  const int prev_calculated,
  const datetime& time[],
  const double& open[],
  const double& high[],
  const double& low[],
  const double& close[],
  const long& tick_volume[],
  const long& volume[],
  const int& spread[])
  {
  int i,limit;
//---
  if(rates_total<=InpSignalSMA || !ExtParameters)
  return(0);
//--- last counted bar will be recounted
  limit=rates_total-prev_calculated;
  if(prev_calculated>0)
  //limit++;
//--- macd counted in the 1-st buffer
  for(i=0; i<limit; i++)
  ExtMacdBuffer[i]=iMA(NULL,0,InpFastEMA,0,MODE_EMA,PRICE_CLOSE,i)-
  iMA(NULL,0,InpSlowEMA,0,MODE_EMA,PRICE_CLOSE,i);
//--- signal line counted in the 2-nd buffer
  SimpleMAOnBuffer(rates_total,prev_calculated,0,InpSignalSMA,ExtMacdBuffer,ExtSignalBuffer);
//--- done
  return(rates_total);
  }*/
//MACD
  double valuem2 = iMACD(TradePairs[i],periodMACD3,FastPeriod2,SlowPeriod2,SignPeriod2,Price,MODE_MAIN  ,0); //Times[t] no lugar no period
  double values2 = iMACD(TradePairs[i],periodMACD3,FastPeriod2,SlowPeriod2,SignPeriod2,Price,MODE_SIGNAL,0);
  if (valuem2 > 0)
  if (valuem2 > values2) 
  signals[i].SignalMACDup03=UP;
  if (valuem2 < 0)
  if (valuem2 < values2) 
  signals[i].SignalMACDdn03=DOWN; 
  
  /*signals[i].SignalMACDup=(signals[i].Signalham12==UP&&signals[i].Signalham52==UP);
  signals[i].SignalMACDdn=(signals[i].Signalham12==DOWN&&signals[i].Signalham52==DOWN);*/               
//======================IMA===============01 
  for (int i=0;i<ArraySize(TradePairs);i++)
  {
  double BB1  = iMA(TradePairs[i],TF1,trade_Period_Moving_Average1,0,MODE_LWMA,PRICE_LOW,0);//MM12 //PERIODO TIME FRAME ALTERAR DE PERIOD_M1 PARA NULL OU TF     
  double BB10 = iMA(TradePairs[i],TF1,trade_Period_Moving_Average1,0,MODE_LWMA,PRICE_LOW,0);//MM12       
  
  if(iClose(TradePairs[i],TF1,0)>BB1 )
  signals[i].SignalM01up=UP;
  if(iClose(TradePairs[i],TF1,0)<BB1 )
  signals[i].SignalM01up=DOWN;
  if(iClose(TradePairs[i],TF1,0)>BB10 )
  signals[i].SignalM02dn=UP;
  if(iClose(TradePairs[i],TF1,0)<BB10 )
  signals[i].SignalM02dn=DOWN;
  signals[i].Signalmaup10=(signals[i].SignalM01up==UP&&signals[i].SignalM02dn==UP);
  signals[i].Signalmadn10=(signals[i].SignalM01up==DOWN&&signals[i].SignalM02dn==DOWN); 
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(TradePairs[i],trigger_TF_HM1 ,0);
  double low    = iLow(TradePairs[i],trigger_TF_HM1 ,0);
  double close  = iClose(TradePairs[i],trigger_TF_HM1 ,0);
  double open   = iOpen(TradePairs[i],trigger_TF_HM1 ,0);
  double point  = MarketInfo(TradePairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  }
  else
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
  }
  }
//======================IMA===============02 
  for (int i=0;i<ArraySize(TradePairs);i++) 
  {
  double BB1  = iMA(TradePairs[i],TF2,trade_Period_Moving_Average2,0,MODE_LWMA,PRICE_LOW,0);//MM12      
  double BB10 = iMA(TradePairs[i],TF2,trade_Period_Moving_Average2,0,MODE_LWMA,PRICE_LOW,0);//MM12       
  if(iClose(TradePairs[i],TF2,0)>BB1 )
  signals[i].SignalM03up=UP;
  if(iClose(TradePairs[i],TF2,0)<BB1 )
  signals[i].SignalM03up=DOWN;
  if(iClose(TradePairs[i],TF2,0)>BB10 )
  signals[i].SignalM04dn=UP;
  if(iClose(TradePairs[i],TF2,0)<BB10 )
  signals[i].SignalM04dn=DOWN;
  signals[i].Signalmaup11=(signals[i].SignalM03up==UP&&signals[i].SignalM04dn==UP);
  signals[i].Signalmadn11=(signals[i].SignalM03up==DOWN&&signals[i].SignalM04dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(TradePairs[i],trigger_TF_HM2 ,0);
  double low    = iLow(TradePairs[i],trigger_TF_HM2 ,0);
  double close  = iClose(TradePairs[i],trigger_TF_HM2 ,0);
  double open   = iOpen(TradePairs[i],trigger_TF_HM2 ,0);
  double point  = MarketInfo(TradePairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  }
  else
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
  }
  }
//======================IMA===============03 
  for (int i=0;i<ArraySize(TradePairs);i++) 
  {
  double BB1  = iMA(TradePairs[i],TF3,trade_Period_Moving_Average3,0,MODE_LWMA,PRICE_LOW,0);//MM12      
  double BB10 = iMA(TradePairs[i],TF3,trade_Period_Moving_Average3,0,MODE_LWMA,PRICE_LOW,0);//MM12       
  if(iClose(TradePairs[i],TF3,0)>BB1 )
  signals[i].SignalM05up=UP;
  if(iClose(TradePairs[i],TF3,0)<BB1 )
  signals[i].SignalM05up=DOWN;
  if(iClose(TradePairs[i],TF3,0)>BB10 )
  signals[i].SignalM06dn=UP;
  if(iClose(TradePairs[i],TF3,0)<BB10 )
  signals[i].SignalM06dn=DOWN;
  signals[i].Signalmaup12=(signals[i].SignalM05up==UP&&signals[i].SignalM06dn==UP);
  signals[i].Signalmadn12=(signals[i].SignalM05up==DOWN&&signals[i].SignalM06dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(TradePairs[i],trigger_TF_HM3 ,0);
  double low    = iLow(TradePairs[i],trigger_TF_HM3 ,0);
  double close  = iClose(TradePairs[i],trigger_TF_HM3 ,0);
  double open   = iOpen(TradePairs[i],trigger_TF_HM3 ,0);
  double point  = MarketInfo(TradePairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0)
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
  }
  }
//======================IMA===============04 
  for (int i=0;i<ArraySize(TradePairs);i++) 
  {
  double BB1  = iMA(TradePairs[i],TF4,trade_Period_Moving_Average4,0,MODE_LWMA,PRICE_LOW,0);//MM21      
  double BB10 = iMA(TradePairs[i],TF4,trade_Period_Moving_Average4,0,MODE_LWMA,PRICE_LOW,0);//MM21       
  if(iClose(TradePairs[i],TF4,0)>BB1 )
  signals[i].SignalM07up=UP;
  if(iClose(TradePairs[i],TF4,0)<BB1 )
  signals[i].SignalM07up=DOWN;
  if(iClose(TradePairs[i],TF4,0)>BB10 )
  signals[i].SignalM08dn=UP;
  if(iClose(TradePairs[i],TF4,0)<BB10 )
  signals[i].SignalM08dn=DOWN;
  signals[i].Signalmaup13=(signals[i].SignalM07up==UP&&signals[i].SignalM08dn==UP);
  signals[i].Signalmadn13=(signals[i].SignalM07up==DOWN&&signals[i].SignalM08dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(TradePairs[i],trigger_TF_HM1 ,0);
  double low    = iLow(TradePairs[i],trigger_TF_HM1 ,0);
  double close  = iClose(TradePairs[i],trigger_TF_HM1 ,0);
  double open   = iOpen(TradePairs[i],trigger_TF_HM1 ,0);
  double point  = MarketInfo(TradePairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
  }
  }
//======================IMA===============05 
  for (int i=0;i<ArraySize(TradePairs);i++) 
  {
  double BB1  = iMA(TradePairs[i],TF5,trade_Period_Moving_Average5,0,MODE_LWMA,PRICE_LOW,0);//MM21      
  double BB10 = iMA(TradePairs[i],TF5,trade_Period_Moving_Average5,0,MODE_LWMA,PRICE_LOW,0);//MM21       
  if(iClose(TradePairs[i],TF5,0)>BB1 )
  signals[i].SignalM09up=UP;
  if(iClose(TradePairs[i],TF5,0)<BB1 )
  signals[i].SignalM09up=DOWN;
  if(iClose(TradePairs[i],TF5,0)>BB10 )
  signals[i].SignalM10dn=UP;
  if(iClose(TradePairs[i],TF5,0)<BB10 )
  signals[i].SignalM10dn=DOWN;
  signals[i].Signalmaup14=(signals[i].SignalM09up==UP&&signals[i].SignalM10dn==UP);
  signals[i].Signalmadn14=(signals[i].SignalM09up==DOWN&&signals[i].SignalM10dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(TradePairs[i],trigger_TF_HM2 ,0);
  double low    = iLow(TradePairs[i],trigger_TF_HM2 ,0);
  double close  = iClose(TradePairs[i],trigger_TF_HM2 ,0);
  double open   = iOpen(TradePairs[i],trigger_TF_HM2 ,0);
  double point  = MarketInfo(TradePairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
  }
  }
//======================IMA===============06
  for (int i=0;i<ArraySize(TradePairs);i++)
  {
  double BB1  = iMA(TradePairs[i],TF6,trade_Period_Moving_Average6,0,MODE_LWMA,PRICE_LOW,0);//MM21      
  double BB10 = iMA(TradePairs[i],TF6,trade_Period_Moving_Average6,0,MODE_LWMA,PRICE_LOW,0);//MM21       
  if(iClose(TradePairs[i],TF6,0)>BB1 )
  signals[i].SignalM11up=UP;
  if(iClose(TradePairs[i],TF6,0)<BB1 )
  signals[i].SignalM11up=DOWN;
  if(iClose(TradePairs[i],TF6,0)>BB10 )
  signals[i].SignalM12dn=UP;
  if(iClose(TradePairs[i],TF6,0)<BB10 )
  signals[i].SignalM12dn=DOWN;
  signals[i].Signalmaup15=(signals[i].SignalM11up==UP&&signals[i].SignalM12dn==UP);
  signals[i].Signalmadn15=(signals[i].SignalM11up==DOWN&&signals[i].SignalM12dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(TradePairs[i],trigger_TF_HM3 ,0);
  double low    = iLow(TradePairs[i],trigger_TF_HM3 ,0);
  double close  = iClose(TradePairs[i],trigger_TF_HM3 ,0);
  double open   = iOpen(TradePairs[i],trigger_TF_HM3 ,0);
  double point  = MarketInfo(TradePairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
  }
  }
//======================IMA===============06 
  for (int i=0;i<ArraySize(TradePairs);i++) 
  {
  double BB1  = iMA(TradePairs[i],TF7,trade_Period_Moving_Average7,0,MODE_LWMA,PRICE_LOW,0);//MM30      
  double BB10 = iMA(TradePairs[i],TF7,trade_Period_Moving_Average7,0,MODE_LWMA,PRICE_LOW,0);//MM30       
  if(iClose(TradePairs[i],TF7,0)>BB1 )
  signals[i].SignalM13up=UP;
  if(iClose(TradePairs[i],TF7,0)<BB1 )
  signals[i].SignalM13up=DOWN;
  if(iClose(TradePairs[i],TF7,0)>BB10 )
  signals[i].SignalM14dn=UP;
  if(iClose(TradePairs[i],TF7,0)<BB10 )
  signals[i].SignalM14dn=DOWN;
  signals[i].Signalmaup1=(signals[i].SignalM13up==UP&&signals[i].SignalM14dn==UP);
  signals[i].Signalmadn1=(signals[i].SignalM13up==DOWN&&signals[i].SignalM14dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(TradePairs[i],trigger_TF_HM1 ,0);
  double low    = iLow(TradePairs[i],trigger_TF_HM1 ,0);
  double close  = iClose(TradePairs[i],trigger_TF_HM1 ,0);
  double open   = iOpen(TradePairs[i],trigger_TF_HM1 ,0);
  double point  = MarketInfo(TradePairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
  }
  } //tirar uma chave para fechar codigo
//======================IMA===============07 
  for (int i=0;i<ArraySize(TradePairs);i++) 
  {
  double BB1  = iMA(TradePairs[i],TF8,trade_Period_Moving_Average8,0,MODE_LWMA,PRICE_LOW,0);//MM30      
  double BB10 = iMA(TradePairs[i],TF8,trade_Period_Moving_Average8,0,MODE_LWMA,PRICE_LOW,0);//MM30       
  if(iClose(TradePairs[i],TF8,0)>BB1 )
  signals[i].SignalM15up=UP;
  if(iClose(TradePairs[i],TF8,0)<BB1 )
  signals[i].SignalM15up=DOWN;
  if(iClose(TradePairs[i],TF8,0)>BB10 )
  signals[i].SignalM16dn=UP;
  if(iClose(TradePairs[i],TF8,0)<BB10 )
  signals[i].SignalM16dn=DOWN;
  signals[i].Signalmaup2=(signals[i].SignalM15up==UP&&signals[i].SignalM16dn==UP);
  signals[i].Signalmadn2=(signals[i].SignalM15up==DOWN&&signals[i].SignalM16dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(TradePairs[i],trigger_TF_HM2 ,0);
  double low    = iLow(TradePairs[i],trigger_TF_HM2 ,0);
  double close  = iClose(TradePairs[i],trigger_TF_HM2 ,0);
  double open   = iOpen(TradePairs[i],trigger_TF_HM2 ,0);
  double point  = MarketInfo(TradePairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
  }
  } //tirar uma chave para fechar codigo
//======================IMA===============08 
  for (int i=0;i<ArraySize(TradePairs);i++) 
  {
  double BB1  = iMA(TradePairs[i],TF9,trade_Period_Moving_Average9,0,MODE_LWMA,PRICE_LOW,0);//MM30      
  double BB10 = iMA(TradePairs[i],TF9,trade_Period_Moving_Average9,0,MODE_LWMA,PRICE_LOW,0);//MM30       
  if(iClose(TradePairs[i],TF9,0)>BB1 )
  signals[i].SignalM17up=UP;
  if(iClose(TradePairs[i],TF9,0)<BB1 )
  signals[i].SignalM17up=DOWN;
  if(iClose(TradePairs[i],TF9,0)>BB10 )
  signals[i].SignalM18dn=UP;
  if(iClose(TradePairs[i],TF9,0)<BB10 )
  signals[i].SignalM18dn=DOWN;
  signals[i].Signalmaup3=(signals[i].SignalM17up==UP&&signals[i].SignalM18dn==UP);
  signals[i].Signalmadn3=(signals[i].SignalM17up==DOWN&&signals[i].SignalM18dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(TradePairs[i],trigger_TF_HM3 ,0);
  double low    = iLow(TradePairs[i],trigger_TF_HM3 ,0);
  double close  = iClose(TradePairs[i],trigger_TF_HM3 ,0);
  double open   = iOpen(TradePairs[i],trigger_TF_HM3 ,0);
  double point  = MarketInfo(TradePairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
  }
  } //tirar uma chave para fechar codigo
//======================IMA===============09
  for (int i=0;i<ArraySize(TradePairs);i++) 
  {
  double BB1  = iMA(TradePairs[i],TF10,trade_Period_Moving_Average10,0,MODE_LWMA,PRICE_LOW,0);//MM50      
  double BB10 = iMA(TradePairs[i],TF10,trade_Period_Moving_Average10,0,MODE_LWMA,PRICE_LOW,0);//MM50       
  if(iClose(TradePairs[i],TF10,0)>BB1 )
  signals[i].SignalM19up=UP;
  if(iClose(TradePairs[i],TF10,0)<BB1 )
  signals[i].SignalM19up=DOWN;
  if(iClose(TradePairs[i],TF10,0)>BB10 )
  signals[i].SignalM20dn=UP;
  if(iClose(TradePairs[i],TF10,0)<BB10 )
  signals[i].SignalM20dn=DOWN;
  signals[i].Signalmaup4=(signals[i].SignalM19up==UP&&signals[i].SignalM20dn==UP);
  signals[i].Signalmadn4=(signals[i].SignalM19up==DOWN&&signals[i].SignalM20dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(TradePairs[i],trigger_TF_HM1 ,0);
  double low    = iLow(TradePairs[i],trigger_TF_HM1 ,0);
  double close  = iClose(TradePairs[i],trigger_TF_HM1 ,0);
  double open   = iOpen(TradePairs[i],trigger_TF_HM1 ,0);
  double point  = MarketInfo(TradePairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
  }
  } //tirar uma chave para fechar codigo
//======================IMA===============10
  for (int i=0;i<ArraySize(TradePairs);i++) 
  {
  double BB1  = iMA(TradePairs[i],TF11,trade_Period_Moving_Average11,0,MODE_LWMA,PRICE_LOW,0);//MM50      
  double BB10 = iMA(TradePairs[i],TF11,trade_Period_Moving_Average11,0,MODE_LWMA,PRICE_LOW,0);//MM50       
  if(iClose(TradePairs[i],TF11,0)>BB1 )
  signals[i].SignalM21up=UP;
  if(iClose(TradePairs[i],TF11,0)<BB1 )
  signals[i].SignalM21up=DOWN;
  if(iClose(TradePairs[i],TF11,0)>BB10 )
  signals[i].SignalM22dn=UP;
  if(iClose(TradePairs[i],TF11,0)<BB10 )
  signals[i].SignalM22dn=DOWN;
  signals[i].Signalmaup5=(signals[i].SignalM21up==UP&&signals[i].SignalM22dn==UP);
  signals[i].Signalmadn5=(signals[i].SignalM21up==DOWN&&signals[i].SignalM22dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(TradePairs[i],trigger_TF_HM2 ,0);
  double low    = iLow(TradePairs[i],trigger_TF_HM2 ,0);
  double close  = iClose(TradePairs[i],trigger_TF_HM2 ,0);
  double open   = iOpen(TradePairs[i],trigger_TF_HM2 ,0);
  double point  = MarketInfo(TradePairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
  }
  } //tirar uma chave para fechar codigo
//======================IMA===============11
  for (int i=0;i<ArraySize(TradePairs);i++) 
  {
  double BB1  = iMA(TradePairs[i],TF12,trade_Period_Moving_Average12,0,MODE_LWMA,PRICE_LOW,0);//MM50      
  double BB10 = iMA(TradePairs[i],TF12,trade_Period_Moving_Average12,0,MODE_LWMA,PRICE_LOW,0);//MM50       
  if(iClose(TradePairs[i],TF12,0)>BB1 )
  signals[i].SignalM23up=UP;
  if(iClose(TradePairs[i],TF12,0)<BB1 )
  signals[i].SignalM23up=DOWN;
  if(iClose(TradePairs[i],TF12,0)>BB10 )
  signals[i].SignalM24dn=UP;
  if(iClose(TradePairs[i],TF12,0)<BB10 )
  signals[i].SignalM24dn=DOWN;
  signals[i].Signalmaup6=(signals[i].SignalM23up==UP&&signals[i].SignalM24dn==UP);
  signals[i].Signalmadn6=(signals[i].SignalM23up==DOWN&&signals[i].SignalM24dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(TradePairs[i],trigger_TF_HM3 ,0);
  double low    = iLow(TradePairs[i],trigger_TF_HM3 ,0);
  double close  = iClose(TradePairs[i],trigger_TF_HM3 ,0);
  double open   = iOpen(TradePairs[i],trigger_TF_HM3 ,0);
  double point  = MarketInfo(TradePairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
  }
  } //tirar uma chave para fechar codigo
//======================IMA===============12
  for (int i=0;i<ArraySize(TradePairs);i++) 
  {
  double BB1  = iMA(TradePairs[i],TF13,trade_Period_Moving_Average13,0,MODE_LWMA,PRICE_LOW,0);//MM100      
  double BB10 = iMA(TradePairs[i],TF13,trade_Period_Moving_Average13,0,MODE_LWMA,PRICE_LOW,0);//MM100       
  if(iClose(TradePairs[i],TF13,0)>BB1 )
  signals[i].SignalM25up=UP;
  if(iClose(TradePairs[i],TF13,0)<BB1 )
  signals[i].SignalM25up=DOWN;
  if(iClose(TradePairs[i],TF13,0)>BB10 )
  signals[i].SignalM26dn=UP;
  if(iClose(TradePairs[i],TF13,0)<BB10 )
  signals[i].SignalM26dn=DOWN;
  signals[i].Signalmaup7=(signals[i].SignalM25up==UP&&signals[i].SignalM26dn==UP);
  signals[i].Signalmadn7=(signals[i].SignalM25up==DOWN&&signals[i].SignalM26dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(TradePairs[i],trigger_TF_HM1 ,0);
  double low    = iLow(TradePairs[i],trigger_TF_HM1 ,0);
  double close  = iClose(TradePairs[i],trigger_TF_HM1 ,0);
  double open   = iOpen(TradePairs[i],trigger_TF_HM1 ,0);
  double point  = MarketInfo(TradePairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
  }
  }
//======================IMA===============13
  for (int i=0;i<ArraySize(TradePairs);i++) 
  {
  double BB1  = iMA(TradePairs[i],TF14,trade_Period_Moving_Average14,0,MODE_LWMA,PRICE_LOW,0);//MM100      
  double BB10 = iMA(TradePairs[i],TF14,trade_Period_Moving_Average14,0,MODE_LWMA,PRICE_LOW,0);//MM100       
  if(iClose(TradePairs[i],TF14,0)>BB1 )
  signals[i].SignalM27up=UP;
  if(iClose(TradePairs[i],TF14,0)<BB1 )
  signals[i].SignalM27up=DOWN;
  if(iClose(TradePairs[i],TF14,0)>BB10 )
  signals[i].SignalM28dn=UP;
  if(iClose(TradePairs[i],TF14,0)<BB10 )
  signals[i].SignalM28dn=DOWN;
  signals[i].Signalmaup8=(signals[i].SignalM27up==UP&&signals[i].SignalM28dn==UP);
  signals[i].Signalmadn8=(signals[i].SignalM27up==DOWN&&signals[i].SignalM28dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(TradePairs[i],trigger_TF_HM2 ,0);
  double low    = iLow(TradePairs[i],trigger_TF_HM2 ,0);
  double close  = iClose(TradePairs[i],trigger_TF_HM2 ,0);
  double open   = iOpen(TradePairs[i],trigger_TF_HM2 ,0);
  double point  = MarketInfo(TradePairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
  }
  }
//======================IMA===============14
  for (int i=0;i<ArraySize(TradePairs);i++) 
  {
  double BB1  = iMA(TradePairs[i],TF15,trade_Period_Moving_Average15,0,MODE_LWMA,PRICE_LOW,0);//MM100      
  double BB10 = iMA(TradePairs[i],TF15,trade_Period_Moving_Average15,0,MODE_LWMA,PRICE_LOW,0);//MM100       
  if(iClose(TradePairs[i],TF15,0)>BB1 )
  signals[i].SignalM29up=UP;
  if(iClose(TradePairs[i],TF15,0)<BB1 )
  signals[i].SignalM29up=DOWN;
  if(iClose(TradePairs[i],TF15,0)>BB10 )
  signals[i].SignalM30dn=UP;
  if(iClose(TradePairs[i],TF15,0)<BB10 )
  signals[i].SignalM30dn=DOWN;
  signals[i].Signalmaup9=(signals[i].SignalM29up==UP&&signals[i].SignalM30dn==UP);
  signals[i].Signalmadn9=(signals[i].SignalM29up==DOWN&&signals[i].SignalM30dn==DOWN);   
  signals[i].prevSignalusd = signals[i].Signalusd; 
  double high   = iHigh(TradePairs[i],trigger_TF_HM3 ,0);
  double low    = iLow(TradePairs[i],trigger_TF_HM3 ,0);
  double close  = iClose(TradePairs[i],trigger_TF_HM3 ,0);
  double open   = iOpen(TradePairs[i],trigger_TF_HM3 ,0);
  double point  = MarketInfo(TradePairs[i],MODE_POINT);
  double range  = (high-low)*point;
  if (range*point > 0.0) 
  {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } 
  else 
  {
  signals[i].Signalusd = signals[i].prevSignalusd;
  }
  }
//======================RSI===============01
  double Openlast = iRSI(TradePairs[i],periodRSI1,trade_Period_RSI1,0,1);
  double Openbefore = iRSI(TradePairs[i],periodRSI1,trade_Period_RSI1,0,0);
  if (Openlast<Openbefore && Openlast>30) 
  {
  signals[i].Signalrsidn1 = DOWN;
  }
  if (Openlast>Openbefore && Openlast<70)  
  {
  signals[i].Signalrsiup1 = UP;
  }   
  }
  }
//======================RSI===============02
void GetCommodity1() 
  {
  for (int i=0;i<ArraySize(TradePairs);i++) 
  {
  signals[i].Signalrsi = NONE; 
  double Openlast = iRSI(TradePairs[i],periodRSI2,trade_Period_RSI2,0,0);
  double Openbefore = iRSI(TradePairs[i],periodRSI2,trade_Period_RSI2,0,1);
  if (Openlast<Openbefore && Openlast>30) 
  {
  signals[i].Signalrsidn2 = DOWN;
  }
  if (Openlast>Openbefore && Openlast<70)  
  {
  signals[i].Signalrsiup2 = UP;
  }   
  }
  }
//======================RSI===============03
void GetCommodity2() 
  {
  for (int i=0;i<ArraySize(TradePairs);i++) 
  {
  signals[i].Signalrsi = NONE; 
  double Openlast = iRSI(TradePairs[i],periodRSI3,trade_Period_RSI3,0,0);
  double Openbefore = iRSI(TradePairs[i],periodRSI3,trade_Period_RSI3,0,1);
  if (Openlast<Openbefore && Openlast>30) 
  {
  signals[i].Signalrsidn3 = DOWN;
  }
  if (Openlast>Openbefore && Openlast<70)  
  {
  signals[i].Signalrsiup3 = UP;
  }   
  }
  }
void GetCommodity3()
  {
  for (int i=0;i<ArraySize(TradePairs);i++) 
  {
  signals[i].Signalrsi = NONE; 
  }
  }
//-----------------------------------------------------------------------+
  double RSI_Value(string sym)
  {    
  double  valu;
  int    i; 
  double RSI_PRES;

  for(i=0; i<ArraySize(TradePairs); i++)
  {                         
  RSI_PRES    = iRSI(sym,trigger_RSI_Timeframe,trigger_RSI_period,trigger_RSI_Applied,trigger_RSI_shift);   //i+1 => previous bar           
  }
  valu=RSI_PRES;
  
  return(valu);
  
  } 
//-----------------------------------------------------------------------+
void GetTrendChangeRSI() {
  for (int i=0;i<ArraySize(TradePairs);i++) {
  
  signals[i].Signalrsi = NONE;
  
  double Closelast = iRSI(TradePairs[i],trigger_RSI_Timeframe,trigger_RSI_period,trigger_RSI_Applied,0);
  double Closebefore = iRSI(TradePairs[i],trigger_RSI_Timeframe,trigger_RSI_period,trigger_RSI_Applied,1);
  
  if (Closelast<Closebefore && Closelast<=trigger_sell_RSI) {
  
  signals[i].Signalrsi = DOWN;
  }
  
  if (Closelast>Closebefore && Closelast>=trigger_buy_RSI)  {
  
  signals[i].Signalrsi = UP;
  }   
  }
  }
 
  void GetSignals2(){
 
  if ((Alert_Mod == 1) && (LastAlertTime < Time[0]))
  {
  //Alert("New Bar  -  ", Symbol(), "  GAP - " + userTimeFrame  + "  -  " + AccountCompany());   
  LastAlertTime = Time[0];
  
  ArrayResize(signals,ArraySize(TradePairs));
  for (int i=0;i<ArraySize(signals);i++) {
  signals[i].xLBSr = signals[i].strength5;
  
  }
  }
  }
//======================INFORMAÇOES DE CONTA===============
//INFO ACCOUNT
 bool    ShowAccountOrderInfo    = true; //true
 bool    ShowTodayRanges         = false;
 bool    ShowProfitInfo          = false;
 bool    ShowRiskInfo            = true; 
 
 int     RiskStopLoss            = 5;
 string  RiskLevels              = "1,5,10,20,40,50,60,80,100";

 bool    OnlyAttachedSymbol      = false;
 int     MagicNumber             = -1;
 string  CommentFilter           = "";
input string  StartDateFilter         = "2023.11.16"; //aaaa-mm-dd
//input int     FontSize                = 8;
 bool    WhiteMode               = false;

int      windowIndex                   = 0;
string   preCurrSign                   = "";
string   postCurrSign                  = "";
double   pip_multiplier                = 1.0;
int      daySeconds                    = 86400;

double   MaxDD            = 0,
         MaxDDp           = 0,
         CurrentDD        = 0, 
         CurrentDDp       = 0;

datetime maxDDDay;
datetime startDateFilter = 0;
datetime LastDrawProfitInfo = 0;

//string   IndiName                      = "InfoTrade v1.0";

/*******************  Version history  ********************************
   
 
***********************************************************************/

//+------------------------------------------------------------------+
/*int init() 
{
//+------------------------------------------------------------------+
	//IndicatorShortName(IndiName);
   DeleteAllObject();

   SetPipMultiplier(Symbol());

   setCurrency();
   
   // Load today max DD from global
   maxDDDay     = getGlobalVar("TRADEINFO_DD_DAY", 0);
   if (maxDDDay >= iTime(Symbol(), PERIOD_D1, 0))
   {
      MaxDD    = getGlobalVar("TRADEINFO_MAXDD", 0);
      MaxDDp   = getGlobalVar("TRADEINFO_MAXDDP", 0);
   } else {
   
      maxDDDay = iTime(Symbol(), PERIOD_D1, 0);
      MaxDD    = 0;
      MaxDDp   = 0;      
   }
   
   if (StartDateFilter != "")
      startDateFilter = StrToTime(StartDateFilter);

   
   return(0);
}
*/
//+------------------------------------------------------------------+
int start() 
{
//+------------------------------------------------------------------+
   DoWork(); 

   return(0); 
}

//+------------------------------------------------------------------+
void DoWork() {
//+------------------------------------------------------------------+
//   windowIndex = WindowFind(IndiName);

   CalculateDailyDrawDown();

   if (ShowAccountOrderInfo) DrawAccountInfo();
   if (ShowAccountOrderInfo) DrawCurrentTrades();  
   if (ShowTodayRanges) DrawTodayRange();
   if (ShowProfitInfo) DrawProfitHistory();
   if (ShowRiskInfo) DrawRiskInfo(); 
   //DrawCopyright();
}

//+------------------------------------------------------------------+
//int deinit() {
//+------------------------------------------------------------------+
//   DeleteAllObject();

//  return(0);
//}

//+------------------------------------------------------------------+
void CalculateDailyDrawDown() {
//+------------------------------------------------------------------+
   double balance = AccountBalance();

   if (balance != 0)
   {
      CurrentDD = 0.0 - ( AccountMargin() + (AccountBalance() - AccountEquity()));
      CurrentDDp = MathDiv(CurrentDD, balance) * 100.0;

      if (CurrentDD < MaxDD || iTime(Symbol(), PERIOD_D1, 0) > maxDDDay)
      {
         MaxDD    = CurrentDD;
         MaxDDp   = CurrentDDp;
         maxDDDay = iTime(Symbol(), PERIOD_D1, 0);
         
         // Save to Global
         setGlobalVar("TRADEINFO_MAXDD",  MaxDD);
         setGlobalVar("TRADEINFO_MAXDDP", MaxDDp);
         setGlobalVar("TRADEINFO_DD_DAY", maxDDDay);
      }

   }
}

//+------------------------------------------------------------------+
double ND(double value, int decimal = -1) { 
//+------------------------------------------------------------------+
   if (decimal == -1)
      decimal = Digits();
   
   return (NormalizeDouble(value, decimal)); 
}

//+------------------------------------------------------------------+
string CutAt(string& str, string sep) {
//+------------------------------------------------------------------+
   string res = "";
   
   int index = StringFind(str, sep, 0);
   if (index != -1)
   {
      if (index > 0) res = StringSubstr(str, 0, index);
      str = StringSubstr(str, index + StringLen(sep));    
   } else {
      res = str;
      str = "";
   }
   return(res);
}

//+------------------------------------------------------------------+
color levelColors[10] = {Lime, SpringGreen, SpringGreen, LawnGreen, Gold, Gold, DarkSalmon, Tomato, Tomato, FireBrick};
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
void DrawRiskInfo() {
//+------------------------------------------------------------------+
   SetPipMultiplier(Symbol());

   if (RiskStopLoss > 0)
      DrawText(1, 1, 375, "Risk Order (SL=" + RiskStopLoss + ")", WhiteMode?Black:White, FontSize=8); 
   else
      DrawText(1, 1, 375, "Risk Order", WhiteMode?Black:White, FontSize=8); 
   
//   DrawText(1, 1, 0, "-------------------", WhiteMode?Black:White, FontSize=8); 
   
   string levels = RiskLevels;
   int i = 0;
  
   while (StringLen(levels) > 0)
   {
      string c = StringTrimLeft(StringTrimRight(CutAt(levels, ",")));
      double value = StringToDouble(c);
      
      if (value != EMPTY_VALUE) {
      
         color clr = levelColors[ArraySize(levelColors) - 1];
         if ( i < ArraySize(levelColors))
            clr = levelColors[i];            
      
         DrawText(1, i + 2, 400, StringConcatenate(value, "%:   ", DTS(MM(value), 2) + " lot"), clr, FontSize=8); 
         i++;
         
      }
   } 
}

//+------------------------------------------------------------------+
void DrawAccountInfo() {
//+------------------------------------------------------------------+
   SetPipMultiplier(Symbol());

   int row = 1;
   string text;
   int colWidth1 = 1080;
   color c = WhiteMode?DarkBlue:LightCyan;
   text = StringConcatenate("Saldo:  ", MTS(AccountBalance())); 
   DrawText(0, row, 925, text, c, FontSize =8); 
   
   double eqPercent = 0;
   if (AccountBalance() > 0)
      eqPercent = MathDiv(AccountEquity(), AccountBalance() * 100.0);
   
   text = StringConcatenate("Equity:  ", MTS(AccountEquity()), "  (", DTS(eqPercent, 2), "%)"); 
   DrawText(0, row, colWidth1, text, c, FontSize); 
   row++;
   double marginLevel = 0;
   
   if (AccountMargin() > 0) marginLevel = MathDiv(AccountEquity(), AccountMargin() * 100.0);
   text = StringConcatenate("Margin: ", DTS(AccountMargin(), 2), "  (", DTS(marginLevel, 2), "%)"); 
   DrawText(0, row, 925, text, c, FontSize); 
   
   if (AccountFreeMargin() < 0)
      c = Red;
   text = StringConcatenate("Free Margin: ", DTS(AccountFreeMargin(), 2)); 
   DrawText(0, row, colWidth1, text, c, FontSize); 
   row++;
   c = WhiteMode?DarkBlue:LightCyan;

   text = StringConcatenate("Leverage: 1:", AccountLeverage()); 
   DrawText(0, row, 925, text, c, FontSize); 
   
   text = StringConcatenate("Swap  Long: ", MTS(MarketInfo(Symbol(), MODE_SWAPLONG), 2), "  Short: ", MTS(MarketInfo(Symbol(), MODE_SWAPSHORT), 2)); 
   DrawText(0, row, colWidth1, text, c, FontSize); 
   row++;

//   DrawText(0, row, 0, "------------------------------------------------------------------", Gray, FontSize); 
}

//+------------------------------------------------------------------+
bool IsValidOrder() {
//+------------------------------------------------------------------+
   if (!OnlyAttachedSymbol || OrderSymbol() == Symbol()) 
      if ( MagicNumber == -1 || MagicNumber == OrderMagicNumber() )
         if (CommentFilter == "" || StringFind(OrderComment(), CommentFilter) != -1)
            return(true);

   return(false);
}

//+------------------------------------------------------------------+
void DrawCurrentTrades() {
//+------------------------------------------------------------------+
   int buyCount, sellCount = 0;
   double buyProfit, sellProfit, buyLot, sellLot, buyPip, sellPip = 0;
   double slPip, tpPip;
   double allTPPips, allSLPips = 0;
   double maxLoss, maxProfit = 0;
   color c = White;
   string text = "";
   int colWidth1 = 200;

   for (int i = OrdersTotal() - 1; i >= 0; i--)
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
         if ( IsValidOrder() )
         {
            slPip = 0;
            tpPip = 0;
            if (OrderType() == OP_BUY) {
               buyCount++;
               buyProfit += OrderProfit() + OrderSwap() + OrderCommission();
               buyLot += OrderLots();
               buyPip += point2pip(MarketInfo(OrderSymbol(), MODE_BID) - OrderOpenPrice(), OrderSymbol());

               if (OrderStopLoss() > 0.0) slPip = point2pip(OrderOpenPrice() - OrderStopLoss(), OrderSymbol());
               if (OrderTakeProfit() > 0.0) tpPip = point2pip(OrderTakeProfit() - OrderOpenPrice(), OrderSymbol());
                  
            } else if (OrderType() == OP_SELL) {
               sellCount++;
               sellProfit += OrderProfit() + OrderSwap() + OrderCommission();
               sellLot += OrderLots();
               sellPip += point2pip(OrderOpenPrice() - MarketInfo(OrderSymbol(), MODE_BID), OrderSymbol());

               if (OrderStopLoss() > 0.0) slPip = point2pip(OrderStopLoss() - OrderOpenPrice(), OrderSymbol());
               if (OrderTakeProfit() > 0.0) tpPip = point2pip(OrderOpenPrice() - OrderTakeProfit(), OrderSymbol());
            }         
            if (slPip != 0) {
               maxLoss -= pip2money(slPip, OrderLots(), OrderSymbol());
               allSLPips -= slPip;
            }
            
            if (tpPip != 0) {
               maxProfit += pip2money(tpPip, OrderLots(), OrderSymbol()) + OrderSwap() + OrderCommission();
               allTPPips += tpPip;
            }
            
         }

   SetPipMultiplier(Symbol());

   int row = 5;

   //Spread   
   double spread = MathDiv(MarketInfo(Symbol(), MODE_SPREAD), pip_multiplier);
   if (spread < 3) c = WhiteMode?DarkGreen:LawnGreen; else c = Crimson;   
   text = StringConcatenate("Spread: ", DTS(spread, 2)); 
   DrawText(0, row=4, 925, text, c, FontSize=8); 

   //Drawdown
   if (CurrentDD < 0) c = WhiteMode?Red:LightPink; else if (CurrentDD == 0.0) c = WhiteMode?Black:White; else c = WhiteMode?DarkGreen:LawnGreen;
   text = StringConcatenate("Current DD: ", DTS(CurrentDD, 2), "   (" + DTS(CurrentDDp, 2), "%)"); 
   DrawText(0, row, colWidth1=1080, text, c, FontSize=8); 
   row++;

   //Max daily Drawdown
   if (MaxDD < 0) c = WhiteMode?Red:LightPink; else if (MaxDD == 0.0) c = WhiteMode?Black:White; else c = WhiteMode?DarkGreen:LawnGreen;
   text = StringConcatenate("Max. Daily DD: ", DTS(MaxDD, 2), "   (" + DTS(MaxDDp, 2), "%)"); 
   DrawText(0, row, colWidth1, text, c, FontSize=8); 
   row++;


   //Max loss + profit
   if (maxProfit < 0) c = FireBrick; else if (maxProfit > 0) c = WhiteMode?DarkGreen:LawnGreen; else c = WhiteMode?Black:White;
   text = StringConcatenate("Profit: ", MTS(maxProfit), "  (", DTS(allTPPips, 1), " pips)"); 
   DrawText(0, row, 925, text, c, FontSize=8); 

   if (maxLoss < 0) c = Red; else if (maxLoss > 0) c = WhiteMode?DarkGreen:LawnGreen; else c = WhiteMode?Black:White;
   double maxLossp = 0; if (AccountBalance() > 0) maxLossp = MathDiv(maxLoss, AccountBalance() * 100);
   text = StringConcatenate("Max loss:  ", MTS(maxLoss), "  (", DTS(allSLPips, 1), " pips)  (", DTS(maxLossp, 2), "%)"); 
   DrawText(0, row, colWidth1, text, c, FontSize=8); 
   row++;
   
//   DrawText(0, row, 0, "------------------------------------------------------------------", Gray, FontSize); 
   row++;

   //Order counts
   c = WhiteMode?DimGray:Gainsboro;
   text = StringConcatenate("Buy:    ", buyCount); 
   DrawText(0, row - 1, 925, text, c, FontSize=8); 
   text = StringConcatenate("Sell:    ", sellCount); 
   DrawText(0, row, 925, text, c, FontSize=8);  

//   DrawText(0, row + 2, 0, "------------------------------------------------------------------", Gray, FontSize); 
   text = StringConcatenate("Total:  ", buyCount + sellCount); 
   DrawText(0, row + 1, 925, text, c, FontSize=8); 

   // Order lots
   text = StringConcatenate("Lot: ", DTS(buyLot, 2)); 
   DrawText(0, row - 1, 990, text, c, FontSize=8); 
   text = StringConcatenate("Lot: ", DTS(sellLot, 2)); 
   DrawText(0, row , 990, text, c, FontSize=8); 
   text = StringConcatenate("Lot: ", DTS(buyLot + sellLot, 2)); 
   DrawText(0, row + 1, 990, text, c, FontSize=8); 
   
   // Order profits
   if (buyProfit < 0) c = Crimson; else if (buyProfit == 0.0) c = WhiteMode?DimGray:Gainsboro; else c = WhiteMode?DarkGreen:LawnGreen;
   text = StringConcatenate("Profit: ", MTS(buyProfit), "   (", DTS(buyPip, 1), " pips)"); 
   DrawText(0, row - 1, colWidth1, text, c, FontSize=8); 


   if (sellProfit < 0) c = Crimson; else if (sellProfit == 0.0) c = WhiteMode?DimGray:Gainsboro; else c = WhiteMode?DarkGreen:LawnGreen;
   text = StringConcatenate("Profit: ", MTS(sellProfit), "   (", DTS(sellPip, 1), " pips)"); 
   DrawText(0, row, colWidth1, text, c, FontSize=8); 

   if (buyProfit + sellProfit < 0) c = Crimson; else if (buyProfit + sellProfit == 0.0) c = WhiteMode?DimGray:Gainsboro; else c = WhiteMode?DarkGreen:LawnGreen;
   text = StringConcatenate("Profit: ", MTS(buyProfit + sellProfit), "   (", DTS(buyPip + sellPip, 1), " pips)"); 
   DrawText(0, row + 1, colWidth1, text, c, FontSize=8); 
}

//+------------------------------------------------------------------+
void DrawProfitHistory() {
//+------------------------------------------------------------------+
   if (LastDrawProfitInfo > TimeCurrent() - 10) return;
   LastDrawProfitInfo = TimeCurrent();

   datetime day, today, now, prevDay;
   
   int xOffset = 350;
   if (!ShowRiskInfo) xOffset = 5;

   DrawText(1, 0, xOffset + 275, "DATE", Gray, FontSize=8); 
   DrawText(1, 0, xOffset + 230, "PIPS", Gray, FontSize=8); 
   DrawText(1, 0, xOffset + 180, "PROFIT", Gray, FontSize=8); 
   DrawText(1, 0, xOffset + 130, "GAIN %", Gray, FontSize=8); 
   DrawText(1, 0, xOffset + 100 , "LOT", Gray, FontSize=8); 
//   DrawText(1, 1, xOffset     , "====================================", Gray, FontSize=8); 

   now = TimeCurrent();
   today = StrToTime(TimeToStr(now, TIME_DATE));

   DrawDayHistoryLine(xOffset, today, now, 2, "Today");

   day = today; prevDay = GetPreviousDay(day - daySeconds);
   DrawDayHistoryLine(xOffset, prevDay, day, 3, "Yesterday");

   day = prevDay; prevDay = GetPreviousDay(day - daySeconds);
   DrawDayHistoryLine(xOffset, prevDay, day, 4);

   day = prevDay; prevDay = GetPreviousDay(day - daySeconds);
   DrawDayHistoryLine(xOffset, prevDay, day, 5);

   day = prevDay; prevDay = GetPreviousDay(day - daySeconds);
   DrawDayHistoryLine(xOffset, prevDay, day, 6);
   
   day = DateOfMonday();
   DrawDayHistoryLine(xOffset, day, now, 7, "Week");

   day = StrToTime(Year()+"."+Month()+".01");
   DrawDayHistoryLine(xOffset, day, now, 8, "Month");

   day = StrToTime(Year()+".01.01");
   DrawDayHistoryLine(xOffset, day, now, 9, "Year");
   
//   DrawText(1, 10, xOffset, "====================================", Gray, FontSize=8); 

   // Daily & Monthly profit
   if (AccountBalance() != 0.0)
   {
      double pips, profit, lots = 0;
      datetime firstOrderTime = GetHistoryInfoFromDate(day, now, pips, profit, lots);
      if (now - firstOrderTime != 0)
      {
         int oneDay = 86400; //int oneMonth = oneDay * 30.4;
         double daily   = MathDiv(MathDiv(profit, MathDiv(now - firstOrderTime, oneDay)), (AccountBalance() - profit)) * 100.0;
         double monthly = daily * 30.4;

         DrawText(1, 10, xOffset = 430, StringConcatenate("Monthly: ", DTS(monthly, 2), "%"), ColorOnSign(monthly), FontSize=8); 
         DrawText(1, 10, xOffset + 150, StringConcatenate("Daily: ", DTS(daily, 2), "%"), ColorOnSign(daily), FontSize=8); 
      }
   }

//   DrawText(1, 12, xOffset = 360, "====================================", Gray, FontSize=8); 
}

//+------------------------------------------------------------------+
double MathDiv(double a, double b) {
//+------------------------------------------------------------------+
   if (b != 0.0)
      return(a/b);

   return(0.0);
}  

//+------------------------------------------------------------------+
void DrawDayHistoryLine(int xOffset, datetime prevDay, datetime day, int row, string header = "") {
//+------------------------------------------------------------------+
   if (header == "") header = TimeToStr(prevDay, TIME_DATE); 

   double pips, profit, percent, lots = 0.0;
   string text;
   
   GetHistoryInfoFromDate(prevDay, day, pips, profit, lots);
   double profitp = 0;
   if (AccountBalance() > 0) profitp = MathDiv(profit, (AccountBalance() - profit)) * 100.0;
   
   text = StringConcatenate(header, ": "); 
   DrawText(1, row, xOffset + 270, text, WhiteMode?DimGray:Gray, FontSize=8); 

   text = DTS(pips, 1); 
   DrawText(1, row, xOffset + 240, text, ColorOnSign(pips), FontSize=8); 

   text = MTS(profit); 
   DrawText(1, row, xOffset + 195, text, ColorOnSign(profit), FontSize=8); 

   text = StringConcatenate(DTS(profitp, 2), "%"); 
   DrawText(1, row, xOffset + 140, text, ColorOnSign(profitp), FontSize=8); 

   text = DTS(lots, 2); 
   DrawText(1, row, xOffset + 95, text, ColorOnSign(profit), FontSize=8); 
}

//+------------------------------------------------------------------+
void DrawTodayRange() {
//+------------------------------------------------------------------+
   string text;
   
   SetPipMultiplier(Symbol());
   
   double todayPips = point2pip(iHigh(NULL, PERIOD_H1, 0) - iLow(NULL, PERIOD_H1, 0));
   double yesterdayPips = point2pip(iHigh(NULL, PERIOD_H1, 1) - iLow(NULL, PERIOD_H1, 1));

   double thisWeekPips = point2pip(iHigh(NULL, PERIOD_H4, 0) - iLow(NULL, PERIOD_H4, 0));
   double lastWeekPips = point2pip(iHigh(NULL, PERIOD_H4, 1) - iLow(NULL, PERIOD_H4, 1));

   double thisMonthPips = point2pip(iHigh(NULL, PERIOD_D1, 0) - iLow(NULL, PERIOD_D1, 0));
   double lastMonthPips = point2pip(iHigh(NULL, PERIOD_D1, 1) - iLow(NULL, PERIOD_D1, 1));
   
   int colWidth2 = 430;
   int colWidth3 = 540;
   int row = 1;
   color c = C'141,176,241';
   DrawText(0, row, colWidth2, "Today range:", c, FontSize);                  DrawText(0, row, colWidth3, StringConcatenate(DTS(todayPips, 1), " pips"), c, FontSize); 
   DrawText(0, row + 1, colWidth2, "Yesterday range:", c, FontSize);          DrawText(0, row + 1, colWidth3, StringConcatenate(DTS(yesterdayPips, 1), " pips"), c, FontSize); 
   row += 3;
   
   c = C'103,150,237';
   DrawText(0, row, colWidth2, "This week range:", c, FontSize);              DrawText(0, row, colWidth3, StringConcatenate(DTS(thisWeekPips, 1), " pips"), c, FontSize); 
   DrawText(0, row + 1, colWidth2, "Last week range:", c, FontSize);          DrawText(0, row + 1, colWidth3, StringConcatenate(DTS(lastWeekPips, 1), " pips"), c, FontSize); 
   row += 3;

   c = C'65,123,233';
   DrawText(0, row, colWidth2, "This month range:", c, FontSize);             DrawText(0, row, colWidth3, StringConcatenate(DTS(thisMonthPips, 1), " pips"), c, FontSize); 
   DrawText(0, row + 1, colWidth2, "Last month range:", c, FontSize);         DrawText(0, row + 1, colWidth3, StringConcatenate(DTS(lastMonthPips, 1), " pips"), c, FontSize); 
   row += 3;


   datetime nextCandleTime = (Period() * 1440) - (TimeCurrent() - iTime(NULL, 0, 0));

   c = WhiteMode?Orange:Bisque;
   DrawText(0, row, colWidth2, "Novo Dia:", c, FontSize=8);                  DrawText(0, row, colWidth3, TimeToStr(nextCandleTime, TIME_SECONDS), c, FontSize=8); 
}

//+------------------------------------------------------------------+
//void DrawCopyright() {
//+------------------------------------------------------------------+
//   string text = StringConcatenate(IndiName, " - Created by Samurai FX - fb.com/FenixCapital.Ltda"); 
//   DrawText(3, 0, 0, text, DimGray, 7);
//}

//+------------------------------------------------------------------+
datetime GetHistoryInfoFromDate(datetime prevDay, datetime day, double &pips, double &profit, double &lots) {
//+------------------------------------------------------------------+
   datetime res = day;
   int i, k = OrdersHistoryTotal();
   pips = 0;
   profit = 0;
   lots = 0;
  
   for (i = 0; i < k; i++) {
      if (OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) {
         if ( IsValidOrder() ) {
           if (OrderType()==OP_BUY || OrderType()==OP_SELL) {
               if (day >= OrderCloseTime() && OrderCloseTime() >= prevDay && OrderCloseTime() > startDateFilter) {
                  profit += OrderProfit() + OrderCommission() + OrderSwap();

                  if (OrderType() == OP_BUY) {
                     pips += point2pip(OrderClosePrice() - OrderOpenPrice(), OrderSymbol());
                  }
                  if (OrderType() == OP_SELL) {
                     pips += point2pip(OrderOpenPrice() - OrderClosePrice(), OrderSymbol());
                  }                  
                  lots += OrderLots();
                  
                  if (OrderCloseTime() < res) res = OrderCloseTime();
               }
            }
         }
      }
   }
   return(res);
}

//+------------------------------------------------------------------+
datetime GetPreviousDay(datetime curDay) {
//+------------------------------------------------------------------+
   datetime prevDay = curDay;
   
   while (TimeDayOfWeek(prevDay) < 1 || TimeDayOfWeek(prevDay) > 5) prevDay -= daySeconds;
   return(prevDay);
}

//+------------------------------------------------------------------+
datetime DateOfMonday(int no = 0) {
//+------------------------------------------------------------------+
  datetime dt = StrToTime(TimeToStr(TimeCurrent(), TIME_DATE));

  while (TimeDayOfWeek(dt) != 1) dt -= daySeconds;
  dt += no * 7 * daySeconds;

  return(dt);
}

color ColorOnSign(double value) {
  color lcColor = WhiteMode?DimGray:Gray;

  if (value > 0) lcColor = WhiteMode?DarkGreen:Green;
  if (value < 0) lcColor = FireBrick;

  return(lcColor);
}

//+------------------------------------------------------------------+
double MM(double Risk) {
//+------------------------------------------------------------------+
   double SL = RiskStopLoss;
   double NewLOT = 0;

   string Symb = Symbol();                                                    // Symb default value
   double One_Lot = MarketInfo(Symb,MODE_MARGINREQUIRED);                     // margin for 1 LOT
   double Min_Lot = MarketInfo(Symb,MODE_MINLOT);                             // Minimum LOT
   double Max_Lot = MarketInfo(Symb,MODE_MAXLOT);                             // Maximum LOT
   double Step   = MarketInfo(Symb,MODE_LOTSTEP);                             // Lot step
   double Free   = AccountFreeMargin();                                       // Free margin
//-------------------------------------------------------------------------------
   if (SL > 0)                                                                // If set StopLoss
   {               
      double RiskAmount = AccountEquity() * (Risk / 100);                     // Calc risk in money
      double tickValue = MarketInfo(Symb, MODE_TICKVALUE) * pip_multiplier;   // Get how many pips 1 unit price
      
      if (tickValue * SL != 0) NewLOT = RiskAmount / (tickValue * SL);        // Divide Risk price with SL price
      if (Step > 0) NewLOT = MathFloor(NewLOT / Step) * Step; //Round         // Round LOT to step
   }
//-------------------------------------------------------------------------------
   else                                                                       // Dynamic LOT calculation
   {                                                        
      if (Risk > 100)                                                         // If greater then 100
         Risk = 100;                                                          // then 100%
      if (Risk == 0)                                                          // If 0
         NewLOT = Min_Lot;                                                    // then minimal LOT
      else                                                                    
         if (Step > 0 && One_Lot > 0) 
            NewLOT = MathFloor(Free * Risk / 100 / One_Lot / Step) * Step;    // Calc by Risk and round to step
   }
//-------------------------------------------------------------------------------
   if (NewLOT < Min_Lot)                                                      // If smaller than minimum
      NewLOT = Min_Lot;                                                       // set to minimum LOT
   if (NewLOT > Max_Lot)                                                      // If greater than maximum
      NewLOT = Max_Lot;                                                       // set to maximum LOT
//-------------------------------------------------------------------------------
   double margin = NewLOT * One_Lot;                                          // Calc the required margin for LOT
   if (margin > AccountFreeMargin())                                          // If greater than the free
   {                                                                          // Message, alert, ...etczenet, alert....stb.       
      //string msg = "You have not enough money! Free margin: " + DTS(AccountFreeMargin(), 2) + ", Require: " + DTS(margin, 2); 
      //Log.Warning(msg);
      //Print(msg);
      //Alert(msg);
      return(0);                                                              // Return with 0. Skip the order open
   }
   return(NewLOT);                            
}

//+------------------------------------------------------------------+
void setCurrency() {
//+------------------------------------------------------------------+
   string currSign = AccountCurrency();
   if (currSign == "USD") {
      preCurrSign = "$";
      postCurrSign = postCurrSign;   
   } else if (currSign == "EUR") {
      preCurrSign = "";
      postCurrSign = postCurrSign;   
   } else {
      preCurrSign = "";
      postCurrSign = postCurrSign;   
   }
}

//+------------------------------------------------------------------+
string MTS(double value, int decimal = 2) {
//+------------------------------------------------------------------+
   return(StringConcatenate(preCurrSign, DTS(value, decimal), postCurrSign));
}

//+------------------------------------------------------------------+
string DTS(double value, int decimal = 0) { return(DoubleToStr(value, decimal)); }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
double point2pip(double point, string Symb = "") {
//+------------------------------------------------------------------+
   if (Symb == "") Symb = Symbol();

   SetPipMultiplier(Symb);
   
   return(MathDiv(MathDiv(point, MarketInfo(Symb, MODE_POINT)), pip_multiplier));
}

//+------------------------------------------------------------------+
double pip2money(double pip, double lot, string Symb) {
//+------------------------------------------------------------------+
   if (Symb == "") Symb = Symbol();

   SetPipMultiplier(Symb);

   double tickSize = MarketInfo(Symb, MODE_TICKSIZE);
   if (tickSize != 0)
   {
      double onePipValue = MarketInfo(Symb, MODE_TICKVALUE) * (MarketInfo(Symb, MODE_POINT) / tickSize);
      return((pip * pip_multiplier) * onePipValue * lot);
   } else return(0);
}

//+------------------------------------------------------------------+
double SetPipMultiplier(string Symb, bool simple = false) {
//+------------------------------------------------------------------+
   pip_multiplier = 1;
   int digit = MarketInfo(Symb, MODE_DIGITS);
   
   if (simple)
   {
      if (digit % 4 != 0) pip_multiplier = 10; 
        
   } else {
      if (digit == 5 || 
         (digit == 3 && StringFind(Symb, "JPY") > -1) ||     // If 3 digits and currency is JPY
         (digit == 2 && StringFind(Symb, "XAU") > -1) ||     // If 2 digits and currency is gold
         (digit == 2 && StringFind(Symb, "GOLD") > -1) ||    // If 2 digits and currency is gold
         (digit == 3 && StringFind(Symb, "XAG") > -1) ||     // If 3 digits and currency is silver
         (digit == 3 && StringFind(Symb, "SILVER") > -1) ||  // If 3 digits and currency is silver
         (digit == 1))                                       // If 1 digit (CFDs)
            pip_multiplier = 10;
      else if (digit == 6 || 
         (digit == 4 && StringFind(Symb, "JPY") > -1) ||     // If 4 digits and currency is JPY
         (digit == 3 && StringFind(Symb, "XAU") > -1) ||     // If 3 digits and currency is gold
         (digit == 3 && StringFind(Symb, "GOLD") > -1) ||    // If 3 digits and currency is gold
         (digit == 4 && StringFind(Symb, "XAG") > -1) ||     // If 4 digits and currency is silver
         (digit == 4 && StringFind(Symb, "SILVER") > -1) ||  // If 4 digits and currency is silver
         (digit == 2))                                       // If 2 digit (CFDs)
            pip_multiplier = 100;
   }  
   //Print("PipMultiplier: ", pip_multiplier, ", Digits: ", Digits);
   return(pip_multiplier);
}

//+------------------------------------------------------------------+
void DrawText(int corner, int row, int xOffset, string text, color c, int size = 7) {
//+------------------------------------------------------------------+
   string objName = "TradeInfo_" + DTS(corner) + "_" + DTS(xOffset) + "_" + DTS(row);
   if (ObjectFind(objName) != 0) {
      ObjectCreate(objName, OBJ_LABEL, windowIndex, 0, 0);
      ObjectSet(objName, OBJPROP_CORNER, corner);
      ObjectSet(objName, OBJPROP_SELECTABLE, 0);
      ObjectSet(objName, OBJPROP_HIDDEN, 1);
   }

   ObjectSetText(objName, text, size, "Verdana", c);
   ObjectSet(objName, OBJPROP_XDISTANCE, 6 + xOffset);
   ObjectSet(objName, OBJPROP_YDISTANCE, 6 + row * (size + 6));
   ObjectSet(objName, OBJPROP_BACK, false);
}

//+------------------------------------------------------------------+
double getGlobalVar(string name, double defaultValue = EMPTY_VALUE) {
//+------------------------------------------------------------------+
   if (GlobalVariableCheck(name))
      return (GlobalVariableGet(name));
   else 
      return (defaultValue);
}

//+------------------------------------------------------------------+
string setGlobalVar(string name, double value = EMPTY_VALUE) {
//+------------------------------------------------------------------+
   if (value == EMPTY_VALUE)
      GlobalVariableDel(name);
   else  
      GlobalVariableSet(name, value);
      
   return(name);
}

//+------------------------------------------------------------------+
void DeleteAllObject() {
//+------------------------------------------------------------------+
   for(int i = ObjectsTotal() - 1; i >= 0; i--)
      if(StringFind(ObjectName(i), "TradeInfo_", 0) >= 0)
         ObjectDelete(ObjectName(i));

}
//---

//FX MULTI-METER 2

//+------------------------------------------------------------------+
//|                                                  CM_Strength.mq4 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
///*sinput*/ string masterPreamble00 = "CM_GVC_TF_10_";
/*sinput*/ int UpdateInSeconds00  = 1;
/*sinput*/ int xAnchor = -2;
/*sinput*/ int yAnchor = 1;

///*sinput*/ int TF_1            =30;
/*sinput*/ int Period_100        = 1;

int panelWidth = 500;
int panelHeight = 400;

int xWidth = 50;
int yHeight = 11;
int xSpace = 1;
int ySpace = 6;
//color ClrText = clrWhiteSmoke;
color ClrBackground = clrBlack;
color ClrBorder = clrBlack;
int fontSize = 9;

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate00(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
  //---
  //--- return value of prev_calculated for next call
  return(rates_total);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ 
void displayMeter00() {
   
   double arrt[8][3];
   int arr2,arr3;
   arrt[0][0] = currency_strength00(curr[0]); 
   arrt[1][0] = currency_strength00(curr[1]); 
   arrt[2][0] = currency_strength00(curr[2]);
   arrt[3][0] = currency_strength00(curr[3]); 
   arrt[4][0] = currency_strength00(curr[4]); 
   arrt[5][0] = currency_strength00(curr[5]);
   arrt[6][0] = currency_strength00(curr[6]); 
   arrt[7][0] = currency_strength00(curr[7]);
   arrt[0][2] = old_currency_strength00(curr[0]); 
   arrt[1][2] = old_currency_strength00(curr[1]);
   arrt[2][2] = old_currency_strength00(curr[2]);
   arrt[3][2] = old_currency_strength00(curr[3]); 
   arrt[4][2] = old_currency_strength00(curr[4]);
   arrt[5][2] = old_currency_strength00(curr[5]);
   arrt[6][2] = old_currency_strength00(curr[6]);
   arrt[7][2] = old_currency_strength00(curr[7]);
   arrt[0][1] = 0; arrt[1][1] = 1; arrt[2][1] = 2; arrt[3][1] = 3; arrt[4][1] = 4;arrt[5][1] = 5; arrt[6][1] = 6; arrt[7][1] = 7;
   ArraySort(arrt, WHOLE_ARRAY, 0, MODE_DESCEND);
     
  // set the panel
  //string labelName = masterPreamble00 + "Header";

  panelWidth = 1;
  panelWidth = panelWidth + 80;

  panelWidth = panelWidth + 3 * xSpace; // + xWidth;
  panelHeight = 9 * yHeight + 10 * ySpace;
  //string panelName = masterPreamble00 + "MainPanel";
  string strText = "(TF: " + IntegerToString(periodBR00,1) + ";  P: " + IntegerToString(Period_100,1) + ")";
  //SetPanel(panelName,0,xAnchor, yAnchor - 20,panelWidth,panelHeight + 20,ClrBackground,clrWhiteSmoke,3);
  //SetText(masterPreamble + "_label_indiName","Strength",xAnchor + xSpace,yAnchor - 15,ClrText, fontSize);
  //SetText(masterPreamble + "_label_indiName2",strText,xAnchor + xSpace,yAnchor + 5,ClrText, fontSize);
   
  for (int m = 0; m < 8; m++) {
  arr2 = arrt[m][1];
  arr3=(int)arrt[m][2];
  currstrength[m] = arrt[m][0];
  prevstrength[m] = arrt[m][2]; 
  SetText(/*masterPreamble00 +*/ curr[arr2]+"pos00",IntegerToString(m+1)+".",xAnchor+8,yAnchor + (m + 1) * (yHeight + ySpace) + 3,color_for_profit00(arrt[m][0]),fontSize);
  SetText(/*masterPreamble00 +*/ curr[arr2]+"curr00", curr[arr2],xAnchor+23,yAnchor + (m+ 1) * (yHeight + ySpace) + 3,color_for_profit00(arrt[m][0]),fontSize);
  SetText(/*masterPreamble00 +*/ curr[arr2]+"currdig00", DoubleToStr(arrt[m][0],1),xAnchor+53,yAnchor + (m + 1) * (yHeight + ySpace) + 3,color_for_profit00(arrt[m][0]),fontSize);
  // SetText(curr[arr2]+"currdig", DoubleToStr(ratio[m][0],1),x_axis+280,(m*18)+y_axis+17,color_for_profit(arrt[m][0]),12);
        
  if(currstrength[m] > prevstrength[m]){SetObjText(/*masterPreamble00 +*/ "Sdir00"+IntegerToString(m),CharToStr(233),xAnchor+74,yAnchor + (m + 1) * (yHeight + ySpace) + 3,BullColor,fontSize);}
  else if(currstrength[m] < prevstrength[m]){SetObjText(/*masterPreamble00 +*/ "Sdir00"+IntegerToString(m),CharToStr(234),xAnchor+74,yAnchor + (m + 1) * (yHeight + ySpace) + 5,BearColor,fontSize);}
  else {SetObjText(/*masterPreamble00 +*/ "Sdir00"+IntegerToString(m),CharToStr(243),xAnchor+74,yAnchor + (m + 1) * (yHeight + ySpace) + 3,clrYellow,fontSize);}
   
  }
  ChartRedraw(); 
  }
color color_for_profit00(double total) 
  {
  if(total<2.0)
  return (clrRed);
  if(total<=3.0)
  return (clrOrangeRed);
  if(total>7.0)
  return (clrLime);
  if(total>6.0)
  return (clrGreen);
  if(total>5.0)
  return (clrSandyBrown);
  if(total<=5.0)
  return (clrYellow);       
  return(clrSteelBlue);
  }

double currency_strength00(string pair) {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength = 0;
  int cnt1 = 0;
   
  for (int x = 0; x < ArraySize(TradePairs); x++) {
  fact = 0;
  sym = TradePairs[x];
  if (pair == StringSubstr(sym, 0, 3) || pair == StringSubstr(sym, 3, 3)) {
  // sym = sym + tempsym;
  //range = (MarketInfo(sym, MODE_HIGH) - MarketInfo(sym, MODE_LOW)) ;
  range = getHigh(sym, periodBR00,Period_100,0) - getLow(sym, periodBR00,Period_100,0);
  if (range != 0.0) {
  ratio = 100.0 * ((MarketInfo(sym, MODE_BID) - getLow(sym, periodBR00,Period_100,0)) / range );
  if (ratio > 3.0)  fact = 1;
  if (ratio > 10.0) fact = 2;
  if (ratio > 25.0) fact = 3;
  if (ratio > 40.0) fact = 4;
  if (ratio > 50.0) fact = 5;
  if (ratio > 60.0) fact = 6;
  if (ratio > 75.0) fact = 7;
  if (ratio > 90.0) fact = 8;
  if (ratio > 97.0) fact = 9;
  cnt1++;
  if (pair == StringSubstr(sym, 3, 3)) fact = 9 - fact;
  strength += fact;
  // signals[x].strength += fact;
  }
  } 
  }
  // for (int x = 0; x < ArraySize(TradePairs); x++) 
  //if(cnt1!=0)signals[x].strength /= cnt1;
  if(cnt1!=0)strength /= cnt1;
  return (strength);
  }
//-----------------------------------------------------------------------------------+
double old_currency_strength00(string pair) 
  {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength=0;
  int cnt1=0;

  for(int x=0; x<ArraySize(TradePairs); x++) 
  {
  fact= 0;
  sym = TradePairs[x];
  int bar = iBarShift(TradePairs[x],PERIOD_M1,TimeCurrent()-60*periodBR00);
  double prevbid = iClose(TradePairs[x],PERIOD_M1,bar);
      
  if(pair==StringSubstr(sym,0,3) || pair==StringSubstr(sym,3,3)) 
  {
  // sym = sym + tempsym;
  range=(getHigh(sym, periodBR00,Period_100,0)-getLow(sym, periodBR00,Period_100,0));
  if(range!=0.0) 
  {
  ratio=100.0 *((prevbid-getLow(sym, periodBR00,Period_100,0))/range);

  if(ratio > 3.0)  fact = 1;
  if(ratio > 10.0) fact = 2;
  if(ratio > 25.0) fact = 3;
  if(ratio > 40.0) fact = 4;
  if(ratio > 50.0) fact = 5;
  if(ratio > 60.0) fact = 6;
  if(ratio > 75.0) fact = 7;
  if(ratio > 90.0) fact = 8;
  if(ratio > 97.0) fact = 9;
            
  cnt1++;

  if(pair==StringSubstr(sym,3,3))
  fact= 9-fact;

  strength+=fact;

  }
  }
  }
  if(cnt1!=0)
  strength/=cnt1;

  return (strength);
  
  }
//-----------------------------------------------------------------------------------------------+ 
void GetSignals00() {
  int cnt = 0;
  ArrayResize(signals,ArraySize(TradePairs));
  for (int i=0;i<ArraySize(signals);i++) {
  signals[i].symbol=TradePairs[i]; 
  signals[i].point=MarketInfo(signals[i].symbol,MODE_POINT);
  signals[i].open=iOpen(signals[i].symbol,periodBR00,Period_100);      
  signals[i].close=iClose(signals[i].symbol,periodBR00,0);
  signals[i].hi=getLow(signals[i].symbol, periodBR00,Period_100,0); //MarketInfo(signals[i].symbol,MODE_HIGH);
  signals[i].lo=getLow(signals[i].symbol, periodBR00,Period_100,0); //MarketInfo(signals[i].symbol,MODE_LOW);
  signals[i].bid=MarketInfo(signals[i].symbol,MODE_BID);
  signals[i].range=(signals[i].hi-signals[i].lo);
  signals[i].shift = iBarShift(signals[i].symbol,PERIOD_M1,TimeCurrent()-periodBR00 * 60);
  signals[i].prevbid = iClose(signals[i].symbol,PERIOD_M1,signals[i].shift);
                 
  if(signals[i].range!=0) {            
  signals[i].ratio=MathMin(((signals[i].bid-signals[i].lo)/signals[i].range*100 ),100);
  signals[i].prevratio=MathMin(((signals[i].prevbid-signals[i].lo)/signals[i].range*100 ),100);     
           
  for (int j = 0; j < 8; j++){
            
  if(signals[i].ratio <= 3.0) signals[i].fact = 0;
  if(signals[i].ratio > 3.0)  signals[i].fact = 1;
  if(signals[i].ratio > 10.0) signals[i].fact = 2;
  if(signals[i].ratio > 25.0) signals[i].fact = 3;
  if(signals[i].ratio > 40.0) signals[i].fact = 4;
  if(signals[i].ratio > 50.0) signals[i].fact = 5;
  if(signals[i].ratio > 60.0) signals[i].fact = 6;
  if(signals[i].ratio > 75.0) signals[i].fact = 7;
  if(signals[i].ratio > 90.0) signals[i].fact = 8;
  if(signals[i].ratio > 97.0) signals[i].fact = 9;
  cnt++;
      
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].fact=9-signals[i].fact;
  
  if(curr[j]==StringSubstr(signals[i].symbol,0,3)) 
  {
  signals[i].strength1=signals[i].fact;
  }  
  else
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength2=signals[i].fact;
  }
  signals[i].calc =signals[i].strength1-signals[i].strength2;
  signals[i].strength=currency_strength00(curr[j]);
  if(curr[j]==StringSubstr(signals[i].symbol,0,3))
  {
  signals[i].strength3=signals[i].strength;
  } 
  else
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength4=signals[i].strength;
  }
  signals[i].strength5=(signals[i].strength3-signals[i].strength4);
  signals[i].strength_old00=old_currency_strength00(curr[j]);
  if(curr[j]==StringSubstr(signals[i].symbol,0,3))
  {
  signals[i].strength6=signals[i].strength_old00;
  } 
  else 
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength7=signals[i].strength_old;
  }
  signals[i].strength8=(signals[i].strength6-signals[i].strength7);     
  signals[i].strength_Gap=signals[i].strength5-signals[i].strength8;
  
  if(signals[i].ratio>=trigger_buy_bidratio)
  {
  signals[i].SigRatio=UP;
  } 
  else 
  {
  if(signals[i].ratio<=trigger_sell_bidratio)
  signals[i].SigRatio=DOWN;
  }  
  
  if(signals[i].ratio>signals[i].prevratio){
  signals[i].SigRatioPrev=UP;
  } 
  else 
  {
  if(signals[i].ratio<signals[i].prevratio)
  signals[i].SigRatioPrev=DOWN;
  }      
  
  if(signals[i].calc>=trigger_buy_relstrength){
  signals[i].SigRelStr=UP;
  } 
  else 
  {
  if (signals[i].calc<=trigger_sell_relstrength) 
  signals[i].SigRelStr=DOWN;
  } 
  
  if(signals[i].strength5>=trigger_buy_buysellratio){
  signals[i].SigBSRatio=UP;
  } 
  else 
  {
  if (signals[i].calc<=trigger_sell_buysellratio) 
  signals[i].SigBSRatio=DOWN;
  }       
  
  if(signals[i].strength_Gap>=trigger_gap_buy){
  signals[i].SigGap=UP;
  } 
  else 
  {
  if (signals[i].strength_Gap<=trigger_gap_sell) 
  signals[i].SigGap=DOWN;
  }
  
  if(signals[i].strength5>signals[i].strength8){
  signals[i].SigGapPrev=UP;
  } 
  else 
  {
  if(signals[i].strength5<signals[i].strength8)      
  signals[i].SigGapPrev=DOWN;
  }  
  }
  }
  }    
  }
//+------------------------------------------------------------------+
double getHigh(string _symbol, int _tf, int _lookBack, int _shift)
  {
  double high = -500000;
  for (int u = 0; u < _lookBack; u++)
  {
  if (iHigh(_symbol, _tf, _shift+u) > high)
  {
  high = iHigh(_symbol, _tf, _shift+u);
  }
  }
  return high;
  }

double getLow(string _symbol, int _tf, int _lookBack, int _shift)
  {
  double low = 500000;
  for (int u = 0; u < _lookBack; u++)
  {
  if (iLow(_symbol, _tf, _shift+u) < low)
  {
  low = iLow(_symbol, _tf, _shift+u);
  }
  }
  return low;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
///*sinput*/ string masterPreamble11 = "CM_GVC_TF_10_11";
/*sinput*/ int UpdateInSeconds11  = 1;
/*sinput*/ int xAnchor11 = 420;
/*sinput*/ int yAnchor11 = 10;

///*sinput*/ int TF_1            =30;
/*sinput*/ int Period_111        = 1;

int panelWidth11 = 500;
int panelHeight11 = 400;

int xWidth11 = 50;
int yHeight11 = 11;
int xSpace11 = 1;
int ySpace11 = 5;
color ClrText11 = clrWhiteSmoke;
color ClrBackground11 = clrBlack;
color ClrBorder11 = clrBlack;
int fontSize11 = 7;
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate11(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
  //---
  //--- return value of prev_calculated for next call
  return(rates_total);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ 
void displayMeter11() {
   
   double arrt[8][3];
   int arr2,arr3;
   arrt[0][0] = currency_strength11(curr[0]); 
   arrt[1][0] = currency_strength11(curr[1]); 
   arrt[2][0] = currency_strength11(curr[2]);
   arrt[3][0] = currency_strength11(curr[3]); 
   arrt[4][0] = currency_strength11(curr[4]); 
   arrt[5][0] = currency_strength11(curr[5]);
   arrt[6][0] = currency_strength11(curr[6]); 
   arrt[7][0] = currency_strength11(curr[7]);
   arrt[0][2] = old_currency_strength11(curr[0]); 
   arrt[1][2] = old_currency_strength11(curr[1]);
   arrt[2][2] = old_currency_strength11(curr[2]);
   arrt[3][2] = old_currency_strength11(curr[3]); 
   arrt[4][2] = old_currency_strength11(curr[4]);
   arrt[5][2] = old_currency_strength11(curr[5]);
   arrt[6][2] = old_currency_strength11(curr[6]);
   arrt[7][2] = old_currency_strength11(curr[7]);
   arrt[0][1] = 0; arrt[1][1] = 1; arrt[2][1] = 2; arrt[3][1] = 3; arrt[4][1] = 4;arrt[5][1] = 5; arrt[6][1] = 6; arrt[7][1] = 7;
   ArraySort(arrt, WHOLE_ARRAY, 0, MODE_DESCEND);
     
  // set the panel
  //string labelName = masterPreamble11 + "Header";

  panelWidth = 1;
  panelWidth = panelWidth + 80;

  panelWidth = panelWidth + 3 * xSpace; // + xWidth;
  panelHeight = 9 * yHeight + 10 * ySpace;
  //string panelName = masterPreamble11 + "MainPanel";
  string strText = "(TF: " + IntegerToString(periodBR11,1) + ";  P: " + IntegerToString(Period_111,1) + ")";
  //SetPanel(panelName,0,xAnchor, yAnchor - 20,panelWidth,panelHeight + 20,ClrBackground,clrWhiteSmoke,3);
  //SetText(masterPreamble11 + "_label_indiName","Strength",xAnchor + xSpace,yAnchor - 15,ClrText, fontSize);
  //SetText(masterPreamble11 + "_label_indiName2",strText,xAnchor + xSpace,yAnchor + 5,ClrText, fontSize);
  
  for (int m = 0; m < 8; m++) {
  arr2 = arrt[m][1];
  arr3=(int)arrt[m][2];
  currstrength[m] = arrt[m][0];
  prevstrength[m] = arrt[m][2]; 
  SetText(/*masterPreamble11 +*/ curr[arr2]+"pos11",IntegerToString(m+1)+".",xAnchor+123,yAnchor + (m + 1) * (yHeight + ySpace) + 3,color_for_profit11(arrt[m][0]),fontSize);
  SetText(/*masterPreamble11 +*/ curr[arr2]+"curr11", curr[arr2],xAnchor+138,yAnchor + (m+ 1) * (yHeight + ySpace) + 3,color_for_profit11(arrt[m][0]),fontSize);
  SetText(/*masterPreamble11 +*/ curr[arr2]+"currdig11", DoubleToStr(arrt[m][0],1),xAnchor+168,yAnchor + (m + 1) * (yHeight + ySpace) + 3,color_for_profit11(arrt[m][0]),fontSize);
  // SetText(curr[arr2]+"currdig", DoubleToStr(ratio[m][0],1),x_axis+280,(m*18)+y_axis+17,color_for_profit(arrt[m][0]),12);
        
  if(currstrength[m] > prevstrength[m]){SetObjText(/*masterPreamble11 +*/ "Sdir11"+IntegerToString(m),CharToStr(233),xAnchor+189,yAnchor + (m + 1) * (yHeight + ySpace) + 3,BullColor,fontSize);}
  else if(currstrength[m] < prevstrength[m]){SetObjText(/*masterPreamble11 +*/ "Sdir11"+IntegerToString(m),CharToStr(234),xAnchor+189,yAnchor + (m + 1) * (yHeight + ySpace) + 5,BearColor,fontSize);}
  else {SetObjText(/*masterPreamble11 +*/ "Sdir11"+IntegerToString(m),CharToStr(243),xAnchor+189,yAnchor + (m + 1) * (yHeight + ySpace) + 3,clrYellow,fontSize);}
         
  }
  ChartRedraw(); 
  }
color color_for_profit11(double total) 
  {
  if(total<2.0)
  return (clrRed);
  if(total<=3.0)
  return (clrOrangeRed);
  if(total>7.0)
  return (clrLime);
  if(total>6.0)
  return (clrGreen);
  if(total>5.0)
  return (clrSandyBrown);
  if(total<=5.0)
  return (clrYellow);       
  return(clrSteelBlue);
  }

double currency_strength11(string pair) {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength = 0;
  int cnt1 = 0;
   
  for (int x = 0; x < ArraySize(TradePairs); x++) {
  fact = 0;
  sym = TradePairs[x];
  if (pair == StringSubstr(sym, 0, 3) || pair == StringSubstr(sym, 3, 3)) {
  // sym = sym + tempsym;
  //range = (MarketInfo(sym, MODE_HIGH) - MarketInfo(sym, MODE_LOW)) ;
  range = getHigh(sym, periodBR11,Period_111,0) - getLow(sym, periodBR11,Period_111,0);
  if (range != 0.0) {
  ratio = 100.0 * ((MarketInfo(sym, MODE_BID) - getLow(sym, periodBR11,Period_111,0)) / range );
  if (ratio > 3.0)  fact = 1;
  if (ratio > 10.0) fact = 2;
  if (ratio > 25.0) fact = 3;
  if (ratio > 40.0) fact = 4;
  if (ratio > 50.0) fact = 5;
  if (ratio > 60.0) fact = 6;
  if (ratio > 75.0) fact = 7;
  if (ratio > 90.0) fact = 8;
  if (ratio > 97.0) fact = 9;
  cnt1++;
  if (pair == StringSubstr(sym, 3, 3)) fact = 9 - fact;
  strength += fact;
  // signals[x].strength += fact;
  }
  } 
  }
  // for (int x = 0; x < ArraySize(TradePairs); x++) 
  //if(cnt1!=0)signals[x].strength /= cnt1;
  if(cnt1!=0)strength /= cnt1;
  return (strength);
   
  }
//-----------------------------------------------------------------------------------+
double old_currency_strength11(string pair) 
  {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength=0;
  int cnt1=0;

  for(int x=0; x<ArraySize(TradePairs); x++) 
  {
  fact= 0;
  sym = TradePairs[x];
  int bar = iBarShift(TradePairs[x],PERIOD_M1,TimeCurrent()-60*periodBR11);
  double prevbid = iClose(TradePairs[x],PERIOD_M1,bar);
      
  if(pair==StringSubstr(sym,0,3) || pair==StringSubstr(sym,3,3)) 
  {
  // sym = sym + tempsym;
  range=(getHigh(sym, periodBR11,Period_111,0)-getLow(sym, periodBR11,Period_111,0));
  if(range!=0.0) 
  {
  ratio=100.0 *((prevbid-getLow(sym, periodBR11,Period_111,0))/range);

  if(ratio > 3.0)  fact = 1;
  if(ratio > 10.0) fact = 2;
  if(ratio > 25.0) fact = 3;
  if(ratio > 40.0) fact = 4;
  if(ratio > 50.0) fact = 5;
  if(ratio > 60.0) fact = 6;
  if(ratio > 75.0) fact = 7;
  if(ratio > 90.0) fact = 8;
  if(ratio > 97.0) fact = 9;
            
  cnt1++;

  if(pair==StringSubstr(sym,3,3))
  fact= 9-fact;

  strength+=fact;

  }
  }
  }
  if(cnt1!=0)
  strength/=cnt1;
  
  return (strength);
  
  }
//-----------------------------------------------------------------------------------------------+ 
void GetSignals11() {
  int cnt = 0;
  ArrayResize(signals,ArraySize(TradePairs));
  for (int i=0;i<ArraySize(signals);i++) {
  signals[i].symbol=TradePairs[i]; 
  signals[i].point=MarketInfo(signals[i].symbol,MODE_POINT);
  signals[i].open=iOpen(signals[i].symbol,periodBR11,Period_111);      
  signals[i].close=iClose(signals[i].symbol,periodBR11,0);
  signals[i].hi=getLow(signals[i].symbol, periodBR11,Period_111,0); //MarketInfo(signals[i].symbol,MODE_HIGH);
  signals[i].lo=getLow(signals[i].symbol, periodBR11,Period_111,0); //MarketInfo(signals[i].symbol,MODE_LOW);
  signals[i].bid=MarketInfo(signals[i].symbol,MODE_BID);
  signals[i].range=(signals[i].hi-signals[i].lo);
  signals[i].shift = iBarShift(signals[i].symbol,PERIOD_M1,TimeCurrent()-periodBR11 * 60);
  signals[i].prevbid = iClose(signals[i].symbol,PERIOD_M1,signals[i].shift);
                 
  if(signals[i].range!=0) {            
  signals[i].ratio=MathMin(((signals[i].bid-signals[i].lo)/signals[i].range*100 ),100);
  signals[i].prevratio=MathMin(((signals[i].prevbid-signals[i].lo)/signals[i].range*100 ),100);     
           
  for (int j = 0; j < 8; j++){
            
  if(signals[i].ratio <= 3.0) signals[i].fact = 0;
  if(signals[i].ratio > 3.0)  signals[i].fact = 1;
  if(signals[i].ratio > 10.0) signals[i].fact = 2;
  if(signals[i].ratio > 25.0) signals[i].fact = 3;
  if(signals[i].ratio > 40.0) signals[i].fact = 4;
  if(signals[i].ratio > 50.0) signals[i].fact = 5;
  if(signals[i].ratio > 60.0) signals[i].fact = 6;
  if(signals[i].ratio > 75.0) signals[i].fact = 7;
  if(signals[i].ratio > 90.0) signals[i].fact = 8;
  if(signals[i].ratio > 97.0) signals[i].fact = 9;
  cnt++;
      
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].fact=9-signals[i].fact;
  
  if(curr[j]==StringSubstr(signals[i].symbol,0,3)) 
  {
  signals[i].strength1=signals[i].fact;
  }  
  else
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength2=signals[i].fact;
  }
  signals[i].calc =signals[i].strength1-signals[i].strength2;
  signals[i].strength=currency_strength11(curr[j]);
  if(curr[j]==StringSubstr(signals[i].symbol,0,3))
  {
  signals[i].strength3=signals[i].strength;
  } 
  else
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength4=signals[i].strength;
  }
  signals[i].strength5=(signals[i].strength3-signals[i].strength4);
  signals[i].strength_old11=old_currency_strength11(curr[j]);
  if(curr[j]==StringSubstr(signals[i].symbol,0,3))
  {
  signals[i].strength6=signals[i].strength_old11;
  } 
  else 
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength7=signals[i].strength_old11;
  }
  signals[i].strength8=(signals[i].strength6-signals[i].strength7);     
  signals[i].strength_Gap=signals[i].strength5-signals[i].strength8;
  
  if(signals[i].ratio>=trigger_buy_bidratio)
  {
  signals[i].SigRatio=UP;
  } 
  else 
  {
  if(signals[i].ratio<=trigger_sell_bidratio)
  signals[i].SigRatio=DOWN;
  }  
  
  if(signals[i].ratio>signals[i].prevratio){
  signals[i].SigRatioPrev=UP;
  } 
  else 
  {
  if(signals[i].ratio<signals[i].prevratio)
  signals[i].SigRatioPrev=DOWN;
  }      
  
  if(signals[i].calc>=trigger_buy_relstrength){
  signals[i].SigRelStr=UP;
  } 
  else 
  {
  if (signals[i].calc<=trigger_sell_relstrength) 
  signals[i].SigRelStr=DOWN;
  } 
  
  if(signals[i].strength5>=trigger_buy_buysellratio){
  signals[i].SigBSRatio=UP;
  } 
  else 
  {
  if (signals[i].calc<=trigger_sell_buysellratio) 
  signals[i].SigBSRatio=DOWN;
  }       
  
  if(signals[i].strength_Gap>=trigger_gap_buy){
  signals[i].SigGap=UP;
  } 
  else 
  {
  if (signals[i].strength_Gap<=trigger_gap_sell) 
  signals[i].SigGap=DOWN;
  }
  
  if(signals[i].strength5>signals[i].strength8){
  signals[i].SigGapPrev=UP;
  } 
  else 
  {
  if(signals[i].strength5<signals[i].strength8)      
  signals[i].SigGapPrev=DOWN;
  }  
  }
  }
  }    
  }
//+------------------------------------------------------------------+
double getHigh11(string _symbol, int _tf, int _lookBack, int _shift)
  {
  double high = -500000;
  for (int u = 0; u < _lookBack; u++)
  {
  if (iHigh(_symbol, _tf, _shift+u) > high)
  {
  high = iHigh(_symbol, _tf, _shift+u);
  }
  }
  return high;
  }

double getLow11(string _symbol, int _tf, int _lookBack, int _shift)
  {
  double low = 500000;
  for (int u = 0; u < _lookBack; u++)
  {
  if (iLow(_symbol, _tf, _shift+u) < low)
  {
  low = iLow(_symbol, _tf, _shift+u);
  }
  }
  return low;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
///*sinput*/ string masterPreamble22 = "CM_GVC_TF_10_11";
/*sinput*/ int UpdateInSeconds22  = 1;
/*sinput*/ int xAnchor22 = 420;
/*sinput*/ int yAnchor22 = 10;

///*sinput*/ int TF_1            =30;
/*sinput*/ int Period_122        = 1;

int panelWidth22 = 500;
int panelHeight22 = 400;

int xWidth22 = 50;
int yHeight22 = 11;
int xSpace22 = 1;
int ySpace22 = 5;
color ClrText22 = clrWhiteSmoke;
color ClrBackground22 = clrBlack;
color ClrBorder22 = clrBlack;
int fontSize22 = 7;

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate22(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
  //---
  //--- return value of prev_calculated for next call
  return(rates_total);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ 
void displayMeter22() {
   
   double arrt[8][3];
   int arr2,arr3;
   arrt[0][0] = currency_strength22(curr[0]); 
   arrt[1][0] = currency_strength22(curr[1]); 
   arrt[2][0] = currency_strength22(curr[2]);
   arrt[3][0] = currency_strength22(curr[3]); 
   arrt[4][0] = currency_strength22(curr[4]); 
   arrt[5][0] = currency_strength22(curr[5]);
   arrt[6][0] = currency_strength22(curr[6]); 
   arrt[7][0] = currency_strength22(curr[7]);
   arrt[0][2] = old_currency_strength22(curr[0]); 
   arrt[1][2] = old_currency_strength22(curr[1]);
   arrt[2][2] = old_currency_strength22(curr[2]);
   arrt[3][2] = old_currency_strength22(curr[3]); 
   arrt[4][2] = old_currency_strength22(curr[4]);
   arrt[5][2] = old_currency_strength22(curr[5]);
   arrt[6][2] = old_currency_strength22(curr[6]);
   arrt[7][2] = old_currency_strength22(curr[7]);
   arrt[0][1] = 0; arrt[1][1] = 1; arrt[2][1] = 2; arrt[3][1] = 3; arrt[4][1] = 4;arrt[5][1] = 5; arrt[6][1] = 6; arrt[7][1] = 7;
   ArraySort(arrt, WHOLE_ARRAY, 0, MODE_DESCEND);
     
  // set the panel
  //string labelName = masterPreamble22 + "Header";

  panelWidth = 1;
  panelWidth = panelWidth + 80;

  panelWidth = panelWidth + 3 * xSpace; // + xWidth;
  panelHeight = 9 * yHeight + 10 * ySpace;
  //string panelName = masterPreamble22 + "MainPanel";
  string strText = "(TF: " + IntegerToString(periodBR22,1) + ";  P: " + IntegerToString(Period_122,1) + ")";
  //SetPanel(panelName,0,xAnchor, yAnchor - 20,panelWidth,panelHeight + 20,ClrBackground,clrWhiteSmoke,3);
  //SetText(masterPreamble11 + "_label_indiName","Strength",xAnchor + xSpace,yAnchor - 15,ClrText, fontSize);
  //SetText(masterPreamble11 + "_label_indiName2",strText,xAnchor + xSpace,yAnchor + 5,ClrText, fontSize);
   
   
  for (int m = 0; m < 8; m++) {
  arr2 = arrt[m][1];
  arr3=(int)arrt[m][2];
  currstrength[m] = arrt[m][0];
  prevstrength[m] = arrt[m][2]; 
  SetText(/*masterPreamble22 +*/ curr[arr2]+"pos22",IntegerToString(m+1)+".",xAnchor+238,yAnchor + (m + 1) * (yHeight + ySpace) + 3,color_for_profit22(arrt[m][0]),fontSize);
  SetText(/*masterPreamble22 +*/ curr[arr2]+"curr22", curr[arr2],xAnchor+253,yAnchor + (m+ 1) * (yHeight + ySpace) + 3,color_for_profit22(arrt[m][0]),fontSize);
  SetText(/*masterPreamble22 +*/ curr[arr2]+"currdig22", DoubleToStr(arrt[m][0],1),xAnchor+283,yAnchor + (m + 1) * (yHeight + ySpace) + 3,color_for_profit22(arrt[m][0]),fontSize);
  // SetText(curr[arr2]+"currdig", DoubleToStr(ratio[m][0],1),x_axis+280,(m*18)+y_axis+17,color_for_profit(arrt[m][0]),12);
        
  if(currstrength[m] > prevstrength[m]){SetObjText(/*masterPreamble22 +*/ "Sdir22"+IntegerToString(m),CharToStr(233),xAnchor+304,yAnchor + (m + 1) * (yHeight + ySpace) + 3,BullColor,fontSize);}
  else if(currstrength[m] < prevstrength[m]){SetObjText(/*masterPreamble22 +*/ "Sdir22"+IntegerToString(m),CharToStr(234),xAnchor+304,yAnchor + (m + 1) * (yHeight + ySpace) + 5,BearColor,fontSize);}
  else {SetObjText(/*masterPreamble22 +*/ "Sdir22"+IntegerToString(m),CharToStr(243),xAnchor+304,yAnchor + (m + 1) * (yHeight + ySpace) + 3,clrYellow,fontSize);}
         
  }
  ChartRedraw(); 
  }
color color_for_profit22(double total) 
  {
  if(total<2.0)
  return (clrRed);
  if(total<=3.0)
  return (clrOrangeRed);
  if(total>7.0)
  return (clrLime);
  if(total>6.0)
  return (clrGreen);
  if(total>5.0)
  return (clrSandyBrown);
  if(total<=5.0)
  return (clrYellow);       
  return(clrSteelBlue);
  }

double currency_strength22(string pair) {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength = 0;
  int cnt1 = 0;
   
  for (int x = 0; x < ArraySize(TradePairs); x++) {
  fact = 0;
  sym = TradePairs[x];
  if (pair == StringSubstr(sym, 0, 3) || pair == StringSubstr(sym, 3, 3)) {
  // sym = sym + tempsym;
  //range = (MarketInfo(sym, MODE_HIGH) - MarketInfo(sym, MODE_LOW)) ;
  range = getHigh(sym, periodBR22,Period_122,0) - getLow(sym, periodBR22,Period_122,0);
  if (range != 0.0) {
  ratio = 100.0 * ((MarketInfo(sym, MODE_BID) - getLow(sym, periodBR22,Period_122,0)) / range );
  if (ratio > 3.0)  fact = 1;
  if (ratio > 10.0) fact = 2;
  if (ratio > 25.0) fact = 3;
  if (ratio > 40.0) fact = 4;
  if (ratio > 50.0) fact = 5;
  if (ratio > 60.0) fact = 6;
  if (ratio > 75.0) fact = 7;
  if (ratio > 90.0) fact = 8;
  if (ratio > 97.0) fact = 9;
  cnt1++;
  if (pair == StringSubstr(sym, 3, 3)) fact = 9 - fact;
  strength += fact;
  // signals[x].strength += fact;
  }
  } 
  }
  // for (int x = 0; x < ArraySize(TradePairs); x++) 
  //if(cnt1!=0)signals[x].strength /= cnt1;
  if(cnt1!=0)strength /= cnt1;
  return (strength);
   
  }
//-----------------------------------------------------------------------------------+
double old_currency_strength22(string pair) 
  {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength=0;
  int cnt1=0;

  for(int x=0; x<ArraySize(TradePairs); x++) 
  {
  fact= 0;
  sym = TradePairs[x];
  int bar = iBarShift(TradePairs[x],PERIOD_M1,TimeCurrent()-60*periodBR22);
  double prevbid = iClose(TradePairs[x],PERIOD_M1,bar);
      
  if(pair==StringSubstr(sym,0,3) || pair==StringSubstr(sym,3,3)) 
  {
  // sym = sym + tempsym;
  range=(getHigh(sym, periodBR22,Period_122,0)-getLow(sym, periodBR22,Period_122,0));
  if(range!=0.0) 
  {
  ratio=100.0 *((prevbid-getLow(sym, periodBR22,Period_122,0))/range);

  if(ratio > 3.0)  fact = 1;
  if(ratio > 10.0) fact = 2;
  if(ratio > 25.0) fact = 3;
  if(ratio > 40.0) fact = 4;
  if(ratio > 50.0) fact = 5;
  if(ratio > 60.0) fact = 6;
  if(ratio > 75.0) fact = 7;
  if(ratio > 90.0) fact = 8;
  if(ratio > 97.0) fact = 9;
            
  cnt1++;

  if(pair==StringSubstr(sym,3,3))
  fact= 9-fact;

  strength+=fact;

  }
  }
  }
  if(cnt1!=0)
  strength/=cnt1;

  return (strength);
  
  }
//-----------------------------------------------------------------------------------------------+ 
void GetSignals22() {
  int cnt = 0;
  ArrayResize(signals,ArraySize(TradePairs));
  for (int i=0;i<ArraySize(signals);i++) {
  signals[i].symbol=TradePairs[i]; 
  signals[i].point=MarketInfo(signals[i].symbol,MODE_POINT);
  signals[i].open=iOpen(signals[i].symbol,periodBR22,Period_122);      
  signals[i].close=iClose(signals[i].symbol,periodBR22,0);
  signals[i].hi=getLow(signals[i].symbol, periodBR22,Period_122,0); //MarketInfo(signals[i].symbol,MODE_HIGH);
  signals[i].lo=getLow(signals[i].symbol, periodBR22,Period_122,0); //MarketInfo(signals[i].symbol,MODE_LOW);
  signals[i].bid=MarketInfo(signals[i].symbol,MODE_BID);
  signals[i].range=(signals[i].hi-signals[i].lo);
  signals[i].shift = iBarShift(signals[i].symbol,PERIOD_M1,TimeCurrent()-periodBR22 * 60);
  signals[i].prevbid = iClose(signals[i].symbol,PERIOD_M1,signals[i].shift);
                 
  if(signals[i].range!=0) {            
  signals[i].ratio=MathMin(((signals[i].bid-signals[i].lo)/signals[i].range*100 ),100);
  signals[i].prevratio=MathMin(((signals[i].prevbid-signals[i].lo)/signals[i].range*100 ),100);     
           
  for (int j = 0; j < 8; j++){
            
  if(signals[i].ratio <= 3.0) signals[i].fact = 0;
  if(signals[i].ratio > 3.0)  signals[i].fact = 1;
  if(signals[i].ratio > 10.0) signals[i].fact = 2;
  if(signals[i].ratio > 25.0) signals[i].fact = 3;
  if(signals[i].ratio > 40.0) signals[i].fact = 4;
  if(signals[i].ratio > 50.0) signals[i].fact = 5;
  if(signals[i].ratio > 60.0) signals[i].fact = 6;
  if(signals[i].ratio > 75.0) signals[i].fact = 7;
  if(signals[i].ratio > 90.0) signals[i].fact = 8;
  if(signals[i].ratio > 97.0) signals[i].fact = 9;
  cnt++;
      
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].fact=9-signals[i].fact;
  
  if(curr[j]==StringSubstr(signals[i].symbol,0,3)) 
  {
  signals[i].strength1=signals[i].fact;
  }  
  else
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength2=signals[i].fact;
  }
  signals[i].calc =signals[i].strength1-signals[i].strength2;
  signals[i].strength=currency_strength22(curr[j]);
  if(curr[j]==StringSubstr(signals[i].symbol,0,3))
  {
  signals[i].strength3=signals[i].strength;
  } 
  else
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength4=signals[i].strength;
  }
  signals[i].strength5=(signals[i].strength3-signals[i].strength4);
  signals[i].strength_old22=old_currency_strength22(curr[j]);
  if(curr[j]==StringSubstr(signals[i].symbol,0,3))
  {
  signals[i].strength6=signals[i].strength_old22;
  } 
  else 
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength7=signals[i].strength_old22;
  }
  signals[i].strength8=(signals[i].strength6-signals[i].strength7);     
  signals[i].strength_Gap=signals[i].strength5-signals[i].strength8;
  
  if(signals[i].ratio>=trigger_buy_bidratio)
  {
  signals[i].SigRatio=UP;
  } 
  else 
  {
  if(signals[i].ratio<=trigger_sell_bidratio)
  signals[i].SigRatio=DOWN;
  }  
  
  if(signals[i].ratio>signals[i].prevratio){
  signals[i].SigRatioPrev=UP;
  } 
  else 
  {
  if(signals[i].ratio<signals[i].prevratio)
  signals[i].SigRatioPrev=DOWN;
  }      
  
  if(signals[i].calc>=trigger_buy_relstrength){
  signals[i].SigRelStr=UP;
  } 
  else 
  {
  if (signals[i].calc<=trigger_sell_relstrength) 
  signals[i].SigRelStr=DOWN;
  } 
  
  if(signals[i].strength5>=trigger_buy_buysellratio){
  signals[i].SigBSRatio=UP;
  } 
  else 
  {
  if (signals[i].calc<=trigger_sell_buysellratio) 
  signals[i].SigBSRatio=DOWN;
  }       
  
  if(signals[i].strength_Gap>=trigger_gap_buy){
  signals[i].SigGap=UP;
  } 
  else 
  {
  if (signals[i].strength_Gap<=trigger_gap_sell) 
  signals[i].SigGap=DOWN;
  }
  
  if(signals[i].strength5>signals[i].strength8){
  signals[i].SigGapPrev=UP;
  } 
  else 
  {
  if(signals[i].strength5<signals[i].strength8)      
  signals[i].SigGapPrev=DOWN;
  }  
  }
  }
  }    
  }
//+------------------------------------------------------------------+
double getHigh22(string _symbol, int _tf, int _lookBack, int _shift)
  {
  double high = -500000;
  for (int u = 0; u < _lookBack; u++)
  {
  if (iHigh(_symbol, _tf, _shift+u) > high)
  {
  high = iHigh(_symbol, _tf, _shift+u);
  }
  }
  return high;
  }

double getLow22(string _symbol, int _tf, int _lookBack, int _shift)
  {
  double low = 500000;
  for (int u = 0; u < _lookBack; u++)
  {
  if (iLow(_symbol, _tf, _shift+u) < low)
  {
  low = iLow(_symbol, _tf, _shift+u);
  }
  }
  return low;
  }

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
///*sinput*/ string masterPreamble33 = "CM_GVC_TF_10_11";
/*sinput*/ int UpdateInSeconds33  = 1;
/*sinput*/ int xAnchor33 = 420;
/*sinput*/ int yAnchor33 = 10;

///*sinput*/ int TF_1            =30;
/*sinput*/ int Period_133        = 1;

int panelWidth33 = 500;
int panelHeight33 = 400;

int xWidth33 = 50;
int yHeight33 = 11;
int xSpace33 = 1;
int ySpace33 = 5;
color ClrText33 = clrWhiteSmoke;
color ClrBackground33 = clrBlack;
color ClrBorder33 = clrBlack;
int fontSize33 = 7;
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate33(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
  //---
   
  //--- return value of prev_calculated for next call
  return(rates_total);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ 
void displayMeter33() {
   
   double arrt[8][3];
   int arr2,arr3;
   arrt[0][0] = currency_strength33(curr[0]); 
   arrt[1][0] = currency_strength33(curr[1]); 
   arrt[2][0] = currency_strength33(curr[2]);
   arrt[3][0] = currency_strength33(curr[3]); 
   arrt[4][0] = currency_strength33(curr[4]); 
   arrt[5][0] = currency_strength33(curr[5]);
   arrt[6][0] = currency_strength33(curr[6]); 
   arrt[7][0] = currency_strength33(curr[7]);
   arrt[0][2] = old_currency_strength33(curr[0]); 
   arrt[1][2] = old_currency_strength33(curr[1]);
   arrt[2][2] = old_currency_strength33(curr[2]);
   arrt[3][2] = old_currency_strength33(curr[3]); 
   arrt[4][2] = old_currency_strength33(curr[4]);
   arrt[5][2] = old_currency_strength33(curr[5]);
   arrt[6][2] = old_currency_strength33(curr[6]);
   arrt[7][2] = old_currency_strength33(curr[7]);
   arrt[0][1] = 0; arrt[1][1] = 1; arrt[2][1] = 2; arrt[3][1] = 3; arrt[4][1] = 4;arrt[5][1] = 5; arrt[6][1] = 6; arrt[7][1] = 7;
   ArraySort(arrt, WHOLE_ARRAY, 0, MODE_DESCEND);
     
  // set the panel
  //string labelName = masterPreamble33 + "Header";

  panelWidth = 1;
  panelWidth = panelWidth + 80;

  panelWidth = panelWidth + 3 * xSpace; // + xWidth;
  panelHeight = 9 * yHeight + 10 * ySpace;
  //string panelName = masterPreamble33 + "MainPanel";
  string strText = "(TF: " + IntegerToString(periodBR33,1) + ";  P: " + IntegerToString(Period_133,1) + ")";
  //SetPanel(panelName,0,xAnchor, yAnchor - 20,panelWidth,panelHeight + 20,ClrBackground,clrWhiteSmoke,3);
  //SetText(masterPreamble11 + "_label_indiName","Strength",xAnchor + xSpace,yAnchor - 15,ClrText, fontSize);
  //SetText(masterPreamble11 + "_label_indiName2",strText,xAnchor + xSpace,yAnchor + 5,ClrText, fontSize);
   
   
  for (int m = 0; m < 8; m++) {
  arr2 = arrt[m][1];
  arr3=(int)arrt[m][2];
  currstrength[m] = arrt[m][0];
  prevstrength[m] = arrt[m][2]; 
  SetText(/*masterPreamble33 +*/ curr[arr2]+"pos33",IntegerToString(m+1)+".",xAnchor+354,yAnchor + (m + 1) * (yHeight + ySpace) + 3,color_for_profit33(arrt[m][0]),fontSize);
  SetText(/*masterPreamble33 +*/ curr[arr2]+"curr33", curr[arr2],xAnchor+369,yAnchor + (m+ 1) * (yHeight + ySpace) + 3,color_for_profit33(arrt[m][0]),fontSize);
  SetText(/*masterPreamble33 +*/ curr[arr2]+"currdig33", DoubleToStr(arrt[m][0],1),xAnchor+399,yAnchor + (m + 1) * (yHeight + ySpace) + 3,color_for_profit33(arrt[m][0]),fontSize);
  // SetText(curr[arr2]+"currdig", DoubleToStr(ratio[m][0],1),x_axis+280,(m*18)+y_axis+17,color_for_profit(arrt[m][0]),12);
        
  if(currstrength[m] > prevstrength[m]){SetObjText(/*masterPreamble33 +*/ "Sdir33"+IntegerToString(m),CharToStr(233),xAnchor+420,yAnchor + (m + 1) * (yHeight + ySpace) + 3,BullColor,fontSize);}
  else if(currstrength[m] < prevstrength[m]){SetObjText(/*masterPreamble33 +*/ "Sdir33"+IntegerToString(m),CharToStr(234),xAnchor+420,yAnchor + (m + 1) * (yHeight + ySpace) + 5,BearColor,fontSize);}
  else {SetObjText(/*masterPreamble33 +*/ "Sdir33"+IntegerToString(m),CharToStr(243),xAnchor+420,yAnchor + (m + 1) * (yHeight + ySpace) + 3,clrYellow,fontSize);}
         
         
  }
  ChartRedraw(); 
  }
color color_for_profit33(double total) 
  {
  if(total<2.0)
  return (clrRed);
  if(total<=3.0)
  return (clrOrangeRed);
  if(total>7.0)
  return (clrLime);
  if(total>6.0)
  return (clrGreen);
  if(total>5.0)
  return (clrSandyBrown);
  if(total<=5.0)
  return (clrYellow);       
  return(clrSteelBlue);
  }

double currency_strength33(string pair) {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength = 0;
  int cnt1 = 0;
   
  for (int x = 0; x < ArraySize(TradePairs); x++) {
  fact = 0;
  sym = TradePairs[x];
  if (pair == StringSubstr(sym, 0, 3) || pair == StringSubstr(sym, 3, 3)) {
  // sym = sym + tempsym;
  //range = (MarketInfo(sym, MODE_HIGH) - MarketInfo(sym, MODE_LOW)) ;
  range = getHigh(sym, periodBR33,Period_133,0) - getLow(sym, periodBR33,Period_133,0);
  if (range != 0.0) {
  ratio = 100.0 * ((MarketInfo(sym, MODE_BID) - getLow(sym, periodBR33,Period_133,0)) / range );
  if (ratio > 3.0)  fact = 1;
  if (ratio > 10.0) fact = 2;
  if (ratio > 25.0) fact = 3;
  if (ratio > 40.0) fact = 4;
  if (ratio > 50.0) fact = 5;
  if (ratio > 60.0) fact = 6;
  if (ratio > 75.0) fact = 7;
  if (ratio > 90.0) fact = 8;
  if (ratio > 97.0) fact = 9;
  cnt1++;
  if (pair == StringSubstr(sym, 3, 3)) fact = 9 - fact;
  strength += fact;
  // signals[x].strength += fact;
  }
  } 
           
  }
  // for (int x = 0; x < ArraySize(TradePairs); x++) 
  //if(cnt1!=0)signals[x].strength /= cnt1;
  if(cnt1!=0)strength /= cnt1;
  return (strength);
   
  }
//-----------------------------------------------------------------------------------+
double old_currency_strength33(string pair) 
  {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength=0;
  int cnt1=0;

  for(int x=0; x<ArraySize(TradePairs); x++) 
  {
  fact= 0;
  sym = TradePairs[x];
  int bar = iBarShift(TradePairs[x],PERIOD_M1,TimeCurrent()-60*periodBR33);
  double prevbid = iClose(TradePairs[x],PERIOD_M1,bar);
      
  if(pair==StringSubstr(sym,0,3) || pair==StringSubstr(sym,3,3)) 
  {
  // sym = sym + tempsym;
  range=(getHigh(sym, periodBR33,Period_133,0)-getLow(sym, periodBR33,Period_133,0));
  if(range!=0.0) 
  {
  ratio=100.0 *((prevbid-getLow(sym, periodBR33,Period_133,0))/range);

  if(ratio > 3.0)  fact = 1;
  if(ratio > 10.0) fact = 2;
  if(ratio > 25.0) fact = 3;
  if(ratio > 40.0) fact = 4;
  if(ratio > 50.0) fact = 5;
  if(ratio > 60.0) fact = 6;
  if(ratio > 75.0) fact = 7;
  if(ratio > 90.0) fact = 8;
  if(ratio > 97.0) fact = 9;
            
  cnt1++;

  if(pair==StringSubstr(sym,3,3))
  fact= 9-fact;

  strength+=fact;

  }
  }
  }
  if(cnt1!=0)
  strength/=cnt1;
  
  return (strength);
  
  }
//-----------------------------------------------------------------------------------------------+ 
void GetSignals33() {
  int cnt = 0;
  ArrayResize(signals,ArraySize(TradePairs));
  for (int i=0;i<ArraySize(signals);i++) {
  signals[i].symbol=TradePairs[i]; 
  signals[i].point=MarketInfo(signals[i].symbol,MODE_POINT);
  signals[i].open=iOpen(signals[i].symbol,periodBR33,Period_133);      
  signals[i].close=iClose(signals[i].symbol,periodBR33,0);
  signals[i].hi=getLow(signals[i].symbol, periodBR33,Period_133,0); //MarketInfo(signals[i].symbol,MODE_HIGH);
  signals[i].lo=getLow(signals[i].symbol, periodBR33,Period_133,0); //MarketInfo(signals[i].symbol,MODE_LOW);
  signals[i].bid=MarketInfo(signals[i].symbol,MODE_BID);
  signals[i].range=(signals[i].hi-signals[i].lo);
  signals[i].shift = iBarShift(signals[i].symbol,PERIOD_M1,TimeCurrent()-periodBR33 * 60);
  signals[i].prevbid = iClose(signals[i].symbol,PERIOD_M1,signals[i].shift);
                 
  if(signals[i].range!=0) {            
  signals[i].ratio=MathMin(((signals[i].bid-signals[i].lo)/signals[i].range*100 ),100);
  signals[i].prevratio=MathMin(((signals[i].prevbid-signals[i].lo)/signals[i].range*100 ),100);     
           
  for (int j = 0; j < 8; j++){
            
  if(signals[i].ratio <= 3.0) signals[i].fact = 0;
  if(signals[i].ratio > 3.0)  signals[i].fact = 1;
  if(signals[i].ratio > 10.0) signals[i].fact = 2;
  if(signals[i].ratio > 25.0) signals[i].fact = 3;
  if(signals[i].ratio > 40.0) signals[i].fact = 4;
  if(signals[i].ratio > 50.0) signals[i].fact = 5;
  if(signals[i].ratio > 60.0) signals[i].fact = 6;
  if(signals[i].ratio > 75.0) signals[i].fact = 7;
  if(signals[i].ratio > 90.0) signals[i].fact = 8;
  if(signals[i].ratio > 97.0) signals[i].fact = 9;
  cnt++;
      
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].fact=9-signals[i].fact;
  
  if(curr[j]==StringSubstr(signals[i].symbol,0,3)) 
  {
  signals[i].strength1=signals[i].fact;
  }  
  else
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength2=signals[i].fact;
  }
  signals[i].calc =signals[i].strength1-signals[i].strength2;
  signals[i].strength=currency_strength33(curr[j]);
  if(curr[j]==StringSubstr(signals[i].symbol,0,3))
  {
  signals[i].strength3=signals[i].strength;
  } 
  else
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength4=signals[i].strength;
  }
  signals[i].strength5=(signals[i].strength3-signals[i].strength4);
  signals[i].strength_old33=old_currency_strength33(curr[j]);
  if(curr[j]==StringSubstr(signals[i].symbol,0,3))
  {
  signals[i].strength6=signals[i].strength_old33;
  } 
  else 
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength7=signals[i].strength_old33;
  }
  signals[i].strength8=(signals[i].strength6-signals[i].strength7);     
  signals[i].strength_Gap=signals[i].strength5-signals[i].strength8;
  
  if(signals[i].ratio>=trigger_buy_bidratio)
  {
  signals[i].SigRatio=UP;
  } 
  else 
  {
  if(signals[i].ratio<=trigger_sell_bidratio)
  signals[i].SigRatio=DOWN;
  }  
  
  if(signals[i].ratio>signals[i].prevratio){
  signals[i].SigRatioPrev=UP;
  } 
  else 
  {
  if(signals[i].ratio<signals[i].prevratio)
  signals[i].SigRatioPrev=DOWN;
  }      
  
  if(signals[i].calc>=trigger_buy_relstrength){
  signals[i].SigRelStr=UP;
  } 
  else 
  {
  if (signals[i].calc<=trigger_sell_relstrength) 
  signals[i].SigRelStr=DOWN;
  } 
  
  if(signals[i].strength5>=trigger_buy_buysellratio){
  signals[i].SigBSRatio=UP;
  } 
  else 
  {
  if (signals[i].calc<=trigger_sell_buysellratio) 
  signals[i].SigBSRatio=DOWN;
  }       
  
  if(signals[i].strength_Gap>=trigger_gap_buy){
  signals[i].SigGap=UP;
  } 
  else 
  {
  if (signals[i].strength_Gap<=trigger_gap_sell) 
  signals[i].SigGap=DOWN;
  }
  
  if(signals[i].strength5>signals[i].strength8){
  signals[i].SigGapPrev=UP;
  } 
  else 
  {
  if(signals[i].strength5<signals[i].strength8)      
  signals[i].SigGapPrev=DOWN;
  }  
  }
  }
  }    
  }

//+------------------------------------------------------------------+
double getHigh33(string _symbol, int _tf, int _lookBack, int _shift)
  {
  double high = -500000;
  for (int u = 0; u < _lookBack; u++)
  {
  if (iHigh(_symbol, _tf, _shift+u) > high)
  {
  high = iHigh(_symbol, _tf, _shift+u);
  }
  }
  return high;
  }

double getLow33(string _symbol, int _tf, int _lookBack, int _shift)
  {
  double low = 500000;
  for (int u = 0; u < _lookBack; u++)
  {
  if (iLow(_symbol, _tf, _shift+u) < low)
  {
  low = iLow(_symbol, _tf, _shift+u);
  }
  }
  return low;
  }

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
///*sinput*/ string masterPreamble44 = "CM_GVC_TF_10_11";
/*sinput*/ int UpdateInSeconds44  = 1;
/*sinput*/ int xAnchor44 = 420;
/*sinput*/ int yAnchor44 = 10;

///*sinput*/ int TF_1            =30;
/*sinput*/ int Period_144        = 1;

int panelWidth44 = 500;
int panelHeight44 = 400;

int xWidth44 = 50;
int yHeight44 = 11;
int xSpace44 = 1;
int ySpace44 = 5;
color ClrText44 = clrWhiteSmoke;
color ClrBackground44 = clrBlack;
color ClrBorder44 = clrBlack;
int fontSize44 = 7;

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate44(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
  //---
   
  //--- return value of prev_calculated for next call
  return(rates_total);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ 
void displayMeter44() {
   
   double arrt[8][3];
   int arr2,arr3;
   arrt[0][0] = currency_strength44(curr[0]); 
   arrt[1][0] = currency_strength44(curr[1]); 
   arrt[2][0] = currency_strength44(curr[2]);
   arrt[3][0] = currency_strength44(curr[3]); 
   arrt[4][0] = currency_strength44(curr[4]); 
   arrt[5][0] = currency_strength44(curr[5]);
   arrt[6][0] = currency_strength44(curr[6]); 
   arrt[7][0] = currency_strength44(curr[7]);
   arrt[0][2] = old_currency_strength44(curr[0]); 
   arrt[1][2] = old_currency_strength44(curr[1]);
   arrt[2][2] = old_currency_strength44(curr[2]);
   arrt[3][2] = old_currency_strength44(curr[3]); 
   arrt[4][2] = old_currency_strength44(curr[4]);
   arrt[5][2] = old_currency_strength44(curr[5]);
   arrt[6][2] = old_currency_strength44(curr[6]);
   arrt[7][2] = old_currency_strength44(curr[7]);
   arrt[0][1] = 0; arrt[1][1] = 1; arrt[2][1] = 2; arrt[3][1] = 3; arrt[4][1] = 4;arrt[5][1] = 5; arrt[6][1] = 6; arrt[7][1] = 7;
   ArraySort(arrt, WHOLE_ARRAY, 0, MODE_DESCEND);
     
  // set the panel
  //string labelName = masterPreamble44 + "Header";

  panelWidth = 1;
  panelWidth = panelWidth + 80;

  panelWidth = panelWidth + 3 * xSpace; // + xWidth;
  panelHeight = 9 * yHeight + 10 * ySpace;
  //string panelName = masterPreamble44 + "MainPanel";
  string strText = "(TF: " + IntegerToString(periodBR44,1) + ";  P: " + IntegerToString(Period_144,1) + ")";
  //SetPanel(panelName,0,xAnchor, yAnchor - 20,panelWidth,panelHeight + 20,ClrBackground,clrWhiteSmoke,3);
  //SetText(masterPreamble11 + "_label_indiName","Strength",xAnchor + xSpace,yAnchor - 15,ClrText, fontSize);
  //SetText(masterPreamble11 + "_label_indiName2",strText,xAnchor + xSpace,yAnchor + 5,ClrText, fontSize);
   
   
  for (int m = 0; m < 8; m++) {
  arr2 = arrt[m][1];
  arr3=(int)arrt[m][2];
  currstrength[m] = arrt[m][0];
  prevstrength[m] = arrt[m][2]; 
  SetText(/*masterPreamble44 +*/ curr[arr2]+"pos44",IntegerToString(m+1)+".",xAnchor+468,yAnchor + (m + 1) * (yHeight + ySpace) + 3,color_for_profit44(arrt[m][0]),fontSize);
  SetText(/*masterPreamble44 +*/ curr[arr2]+"curr44", curr[arr2],xAnchor+483,yAnchor + (m+ 1) * (yHeight + ySpace) + 3,color_for_profit44(arrt[m][0]),fontSize);
  SetText(/*masterPreamble44 +*/ curr[arr2]+"currdig44", DoubleToStr(arrt[m][0],1),xAnchor+513,yAnchor + (m + 1) * (yHeight + ySpace) + 3,color_for_profit44(arrt[m][0]),fontSize);
  // SetText(curr[arr2]+"currdig", DoubleToStr(ratio[m][0],1),x_axis+280,(m*18)+y_axis+17,color_for_profit(arrt[m][0]),12);
        
  if(currstrength[m] > prevstrength[m]){SetObjText(/*masterPreamble44 +*/ "Sdir44"+IntegerToString(m),CharToStr(233),xAnchor+534,yAnchor + (m + 1) * (yHeight + ySpace) + 3,BullColor,fontSize);}
  else if(currstrength[m] < prevstrength[m]){SetObjText(/*masterPreamble44 +*/ "Sdir44"+IntegerToString(m),CharToStr(234),xAnchor+534,yAnchor + (m + 1) * (yHeight + ySpace) + 5,BearColor,fontSize);}
  else {SetObjText(/*masterPreamble44 +*/ "Sdir44"+IntegerToString(m),CharToStr(243),xAnchor+534,yAnchor + (m + 1) * (yHeight + ySpace) + 3,clrYellow,fontSize);}
         
         
  }
  ChartRedraw(); 
  }
color color_for_profit44(double total) 
  {
  if(total<2.0)
  return (clrRed);
  if(total<=3.0)
  return (clrOrangeRed);
  if(total>7.0)
  return (clrLime);
  if(total>6.0)
  return (clrGreen);
  if(total>5.0)
  return (clrSandyBrown);
  if(total<=5.0)
  return (clrYellow);       
  return(clrSteelBlue);
  }

double currency_strength44(string pair) {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength = 0;
  int cnt1 = 0;
   
  for (int x = 0; x < ArraySize(TradePairs); x++) {
  fact = 0;
  sym = TradePairs[x];
  if (pair == StringSubstr(sym, 0, 3) || pair == StringSubstr(sym, 3, 3)) {
  // sym = sym + tempsym;
  //range = (MarketInfo(sym, MODE_HIGH) - MarketInfo(sym, MODE_LOW)) ;
  range = getHigh(sym, periodBR44,Period_144,0) - getLow(sym, periodBR44,Period_144,0);
  if (range != 0.0) {
  ratio = 100.0 * ((MarketInfo(sym, MODE_BID) - getLow(sym, periodBR44,Period_144,0)) / range );
  if (ratio > 3.0)  fact = 1;
  if (ratio > 10.0) fact = 2;
  if (ratio > 25.0) fact = 3;
  if (ratio > 40.0) fact = 4;
  if (ratio > 50.0) fact = 5;
  if (ratio > 60.0) fact = 6;
  if (ratio > 75.0) fact = 7;
  if (ratio > 90.0) fact = 8;
  if (ratio > 97.0) fact = 9;
  cnt1++;
  if (pair == StringSubstr(sym, 3, 3)) fact = 9 - fact;
  strength += fact;
  // signals[x].strength += fact;
  }
  } 
           
  }
  // for (int x = 0; x < ArraySize(TradePairs); x++) 
  //if(cnt1!=0)signals[x].strength /= cnt1;
  if(cnt1!=0)strength /= cnt1;
  return (strength);
   
  }
//-----------------------------------------------------------------------------------+
double old_currency_strength44(string pair) 
  {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength=0;
  int cnt1=0;

  for(int x=0; x<ArraySize(TradePairs); x++) 
  {
  fact= 0;
  sym = TradePairs[x];
  int bar = iBarShift(TradePairs[x],PERIOD_M1,TimeCurrent()-60*periodBR44);
  double prevbid = iClose(TradePairs[x],PERIOD_M1,bar);
      
  if(pair==StringSubstr(sym,0,3) || pair==StringSubstr(sym,3,3)) 
  {
  // sym = sym + tempsym;
  range=(getHigh(sym, periodBR44,Period_144,0)-getLow(sym, periodBR44,Period_144,0));
  if(range!=0.0) 
  {
  ratio=100.0 *((prevbid-getLow(sym, periodBR44,Period_144,0))/range);

  if(ratio > 3.0)  fact = 1;
  if(ratio > 10.0) fact = 2;
  if(ratio > 25.0) fact = 3;
  if(ratio > 40.0) fact = 4;
  if(ratio > 50.0) fact = 5;
  if(ratio > 60.0) fact = 6;
  if(ratio > 75.0) fact = 7;
  if(ratio > 90.0) fact = 8;
  if(ratio > 97.0) fact = 9;
            
  cnt1++;

  if(pair==StringSubstr(sym,3,3))
  fact= 9-fact;

  strength+=fact;

  }
  }
  }
  if(cnt1!=0)
  strength/=cnt1;

  return (strength);
  
  }
//-----------------------------------------------------------------------------------------------+ 
void GetSignals44() {
  int cnt = 0;
  ArrayResize(signals,ArraySize(TradePairs));
  for (int i=0;i<ArraySize(signals);i++) {
  signals[i].symbol=TradePairs[i]; 
  signals[i].point=MarketInfo(signals[i].symbol,MODE_POINT);
  signals[i].open=iOpen(signals[i].symbol,periodBR44,Period_144);      
  signals[i].close=iClose(signals[i].symbol,periodBR44,0);
  signals[i].hi=getLow(signals[i].symbol, periodBR44,Period_144,0); //MarketInfo(signals[i].symbol,MODE_HIGH);
  signals[i].lo=getLow(signals[i].symbol, periodBR44,Period_144,0); //MarketInfo(signals[i].symbol,MODE_LOW);
  signals[i].bid=MarketInfo(signals[i].symbol,MODE_BID);
  signals[i].range=(signals[i].hi-signals[i].lo);
  signals[i].shift = iBarShift(signals[i].symbol,PERIOD_M1,TimeCurrent()-periodBR44 * 60);
  signals[i].prevbid = iClose(signals[i].symbol,PERIOD_M1,signals[i].shift);
                 
  if(signals[i].range!=0) {            
  signals[i].ratio=MathMin(((signals[i].bid-signals[i].lo)/signals[i].range*100 ),100);
  signals[i].prevratio=MathMin(((signals[i].prevbid-signals[i].lo)/signals[i].range*100 ),100);     
           
  for (int j = 0; j < 8; j++){
            
  if(signals[i].ratio <= 3.0) signals[i].fact = 0;
  if(signals[i].ratio > 3.0)  signals[i].fact = 1;
  if(signals[i].ratio > 10.0) signals[i].fact = 2;
  if(signals[i].ratio > 25.0) signals[i].fact = 3;
  if(signals[i].ratio > 40.0) signals[i].fact = 4;
  if(signals[i].ratio > 50.0) signals[i].fact = 5;
  if(signals[i].ratio > 60.0) signals[i].fact = 6;
  if(signals[i].ratio > 75.0) signals[i].fact = 7;
  if(signals[i].ratio > 90.0) signals[i].fact = 8;
  if(signals[i].ratio > 97.0) signals[i].fact = 9;
  cnt++;
      
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].fact=9-signals[i].fact;
  
  if(curr[j]==StringSubstr(signals[i].symbol,0,3)) 
  {
  signals[i].strength1=signals[i].fact;
  }  
  else
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength2=signals[i].fact;
  }
  signals[i].calc =signals[i].strength1-signals[i].strength2;
  signals[i].strength=currency_strength44(curr[j]);
  if(curr[j]==StringSubstr(signals[i].symbol,0,3))
  {
  signals[i].strength3=signals[i].strength;
  } 
  else
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength4=signals[i].strength;
  }
  signals[i].strength5=(signals[i].strength3-signals[i].strength4);
  signals[i].strength_old44=old_currency_strength44(curr[j]);
  if(curr[j]==StringSubstr(signals[i].symbol,0,3))
  {
  signals[i].strength6=signals[i].strength_old44;
  } 
  else 
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength7=signals[i].strength_old44;
  }
  signals[i].strength8=(signals[i].strength6-signals[i].strength7);     
  signals[i].strength_Gap=signals[i].strength5-signals[i].strength8;
  
  if(signals[i].ratio>=trigger_buy_bidratio)
  {
  signals[i].SigRatio=UP;
  } 
  else 
  {
  if(signals[i].ratio<=trigger_sell_bidratio)
  signals[i].SigRatio=DOWN;
  }  
  
  if(signals[i].ratio>signals[i].prevratio){
  signals[i].SigRatioPrev=UP;
  } 
  else 
  {
  if(signals[i].ratio<signals[i].prevratio)
  signals[i].SigRatioPrev=DOWN;
  }      
  
  if(signals[i].calc>=trigger_buy_relstrength){
  signals[i].SigRelStr=UP;
  } 
  else 
  {
  if (signals[i].calc<=trigger_sell_relstrength) 
  signals[i].SigRelStr=DOWN;
  } 
  
  if(signals[i].strength5>=trigger_buy_buysellratio){
  signals[i].SigBSRatio=UP;
  } 
  else 
  {
  if (signals[i].calc<=trigger_sell_buysellratio) 
  signals[i].SigBSRatio=DOWN;
  }       
  
  if(signals[i].strength_Gap>=trigger_gap_buy){
  signals[i].SigGap=UP;
  } 
  else 
  {
  if (signals[i].strength_Gap<=trigger_gap_sell) 
  signals[i].SigGap=DOWN;
  }
  
  if(signals[i].strength5>signals[i].strength8){
  signals[i].SigGapPrev=UP;
  } 
  else 
  {
  if(signals[i].strength5<signals[i].strength8)      
  signals[i].SigGapPrev=DOWN;
  }  
  }
  }
  }    
  }
//+------------------------------------------------------------------+
double getHigh44(string _symbol, int _tf, int _lookBack, int _shift)
  {
  double high = -500000;
  for (int u = 0; u < _lookBack; u++)
  {
  if (iHigh(_symbol, _tf, _shift+u) > high)
  {
  high = iHigh(_symbol, _tf, _shift+u);
  }
  }
  return high;
  }

double getLow44(string _symbol, int _tf, int _lookBack, int _shift)
  {
  double low = 500000;
  for (int u = 0; u < _lookBack; u++)
  {
  if (iLow(_symbol, _tf, _shift+u) < low)
  {
  low = iLow(_symbol, _tf, _shift+u);
  }
  }
  return low;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
///*sinput*/ string masterPreamble55 = "CM_GVC_TF_10_11";
/*sinput*/ int UpdateInSeconds55  = 1;
/*sinput*/ int xAnchor55 = 420;
/*sinput*/ int yAnchor55 = 10;

///*sinput*/ int TF_1            =30;
/*sinput*/ int Period_155        = 1;

int panelWidth55 = 500;
int panelHeight55 = 400;

int xWidth55 = 50;
int yHeight55 = 11;
int xSpace55 = 1;
int ySpace55 = 5;
color ClrText55 = clrWhiteSmoke;
color ClrBackground55 = clrBlack;
color ClrBorder55 = clrBlack;
int fontSize55 = 7;
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate55(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
  //---
  
  //--- return value of prev_calculated for next call
  return(rates_total);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ 
void displayMeter55() {
   
   double arrt[8][3];
   int arr2,arr3;
   arrt[0][0] = currency_strength55(curr[0]); 
   arrt[1][0] = currency_strength55(curr[1]); 
   arrt[2][0] = currency_strength55(curr[2]);
   arrt[3][0] = currency_strength55(curr[3]); 
   arrt[4][0] = currency_strength55(curr[4]); 
   arrt[5][0] = currency_strength55(curr[5]);
   arrt[6][0] = currency_strength55(curr[6]); 
   arrt[7][0] = currency_strength55(curr[7]);
   arrt[0][2] = old_currency_strength55(curr[0]); 
   arrt[1][2] = old_currency_strength55(curr[1]);
   arrt[2][2] = old_currency_strength55(curr[2]);
   arrt[3][2] = old_currency_strength55(curr[3]); 
   arrt[4][2] = old_currency_strength55(curr[4]);
   arrt[5][2] = old_currency_strength55(curr[5]);
   arrt[6][2] = old_currency_strength55(curr[6]);
   arrt[7][2] = old_currency_strength55(curr[7]);
   arrt[0][1] = 0; arrt[1][1] = 1; arrt[2][1] = 2; arrt[3][1] = 3; arrt[4][1] = 4;arrt[5][1] = 5; arrt[6][1] = 6; arrt[7][1] = 7;
   ArraySort(arrt, WHOLE_ARRAY, 0, MODE_DESCEND);
  
  // set the panel
  //string labelName = masterPreamble55 + "Header";

  panelWidth = 1;
  panelWidth = panelWidth + 80;
  
  panelWidth = panelWidth + 3 * xSpace; // + xWidth;
  panelHeight = 9 * yHeight + 10 * ySpace;
  //string panelName = masterPreamble55 + "MainPanel";
  string strText = "(TF: " + IntegerToString(periodBR55,1) + ";  P: " + IntegerToString(Period_155,1) + ")";
  //SetPanel(panelName,0,xAnchor, yAnchor - 20,panelWidth,panelHeight + 20,ClrBackground,clrWhiteSmoke,3);
  //SetText(masterPreamble11 + "_label_indiName","Strength",xAnchor + xSpace,yAnchor - 15,ClrText, fontSize);
  //SetText(masterPreamble11 + "_label_indiName2",strText,xAnchor + xSpace,yAnchor + 5,ClrText, fontSize);
   
   
  for (int m = 0; m < 8; m++) {
  arr2 = arrt[m][1];
  arr3=(int)arrt[m][2];
  currstrength[m] = arrt[m][0];
  prevstrength[m] = arrt[m][2]; 
  SetText(/*masterPreamble55 +*/ curr[arr2]+"pos55",IntegerToString(m+1)+".",xAnchor+583,yAnchor + (m + 1) * (yHeight + ySpace) + 3,color_for_profit55(arrt[m][0]),fontSize);
  SetText(/*masterPreamble55 +*/ curr[arr2]+"curr55", curr[arr2],xAnchor+598,yAnchor + (m+ 1) * (yHeight + ySpace) + 3,color_for_profit55(arrt[m][0]),fontSize);
  SetText(/*masterPreamble55 +*/ curr[arr2]+"currdig55", DoubleToStr(arrt[m][0],1),xAnchor+628,yAnchor + (m + 1) * (yHeight + ySpace) + 3,color_for_profit55(arrt[m][0]),fontSize);
  // SetText(curr[arr2]+"currdig", DoubleToStr(ratio[m][0],1),x_axis+280,(m*18)+y_axis+17,color_for_profit(arrt[m][0]),12);
  
  if(currstrength[m] > prevstrength[m]){SetObjText(/*masterPreamble55 +*/ "Sdir55"+IntegerToString(m),CharToStr(233),xAnchor+649,yAnchor + (m + 1) * (yHeight + ySpace) + 3,BullColor,fontSize);}
  else if(currstrength[m] < prevstrength[m]){SetObjText(/*masterPreamble55 +*/ "Sdir55"+IntegerToString(m),CharToStr(234),xAnchor+649,yAnchor + (m + 1) * (yHeight + ySpace) + 5,BearColor,fontSize);}
  else {SetObjText(/*masterPreamble55 +*/ "Sdir55"+IntegerToString(m),CharToStr(243),xAnchor+649,yAnchor + (m + 1) * (yHeight + ySpace) + 3,clrYellow,fontSize);}
  
  
  }
  ChartRedraw(); 
  }
color color_for_profit55(double total) 
  {
  if(total<2.0)
  return (clrRed);
  if(total<=3.0)
  return (clrOrangeRed);
  if(total>7.0)
  return (clrLime);
  if(total>6.0)
  return (clrGreen);
  if(total>5.0)
  return (clrSandyBrown);
  if(total<=5.0)
  return (clrYellow);       
  return(clrSteelBlue);
  }

double currency_strength55(string pair) {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength = 0;
  int cnt1 = 0;
  
  for (int x = 0; x < ArraySize(TradePairs); x++) {
  fact = 0;
  sym = TradePairs[x];
  if (pair == StringSubstr(sym, 0, 3) || pair == StringSubstr(sym, 3, 3)) {
  // sym = sym + tempsym;
  //range = (MarketInfo(sym, MODE_HIGH) - MarketInfo(sym, MODE_LOW)) ;
  range = getHigh(sym, periodBR55,Period_155,0) - getLow(sym, periodBR55,Period_155,0);
  if (range != 0.0) {
  ratio = 100.0 * ((MarketInfo(sym, MODE_BID) - getLow(sym, periodBR55,Period_155,0)) / range );
  if (ratio > 3.0)  fact = 1;
  if (ratio > 10.0) fact = 2;
  if (ratio > 25.0) fact = 3;
  if (ratio > 40.0) fact = 4;
  if (ratio > 50.0) fact = 5;
  if (ratio > 60.0) fact = 6;
  if (ratio > 75.0) fact = 7;
  if (ratio > 90.0) fact = 8;
  if (ratio > 97.0) fact = 9;
  cnt1++;
  if (pair == StringSubstr(sym, 3, 3)) fact = 9 - fact;
  strength += fact;
  // signals[x].strength += fact;
  }
  } 
  
  }
  // for (int x = 0; x < ArraySize(TradePairs); x++) 
  //if(cnt1!=0)signals[x].strength /= cnt1;
  if(cnt1!=0)strength /= cnt1;
  return (strength);
  
  }
//-----------------------------------------------------------------------------------+
double old_currency_strength55(string pair) 
  {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength=0;
  int cnt1=0;
  
  for(int x=0; x<ArraySize(TradePairs); x++) 
  {
  fact= 0;
  sym = TradePairs[x];
  int bar = iBarShift(TradePairs[x],PERIOD_M1,TimeCurrent()-60*periodBR55);
  double prevbid = iClose(TradePairs[x],PERIOD_M1,bar);
  
  if(pair==StringSubstr(sym,0,3) || pair==StringSubstr(sym,3,3)) 
  {
  // sym = sym + tempsym;
  range=(getHigh(sym, periodBR55,Period_155,0)-getLow(sym, periodBR55,Period_155,0));
  if(range!=0.0) 
  {
  ratio=100.0 *((prevbid-getLow(sym, periodBR55,Period_155,0))/range);

  if(ratio > 3.0)  fact = 1;
  if(ratio > 10.0) fact = 2;
  if(ratio > 25.0) fact = 3;
  if(ratio > 40.0) fact = 4;
  if(ratio > 50.0) fact = 5;
  if(ratio > 60.0) fact = 6;
  if(ratio > 75.0) fact = 7;
  if(ratio > 90.0) fact = 8;
  if(ratio > 97.0) fact = 9;
  
  cnt1++;
  
  if(pair==StringSubstr(sym,3,3))
  fact=9-fact;
  
  strength+=fact;
  
  }
  }
  }
  if(cnt1!=0)
  strength/=cnt1;
  
  return (strength);
  
  }
//-----------------------------------------------------------------------------------------------+ 
void GetSignals55() {
  int cnt = 0;
  ArrayResize(signals,ArraySize(TradePairs));
  for (int i=0;i<ArraySize(signals);i++) {
  signals[i].symbol=TradePairs[i]; 
  signals[i].point=MarketInfo(signals[i].symbol,MODE_POINT);
  signals[i].open=iOpen(signals[i].symbol,periodBR55,Period_155);      
  signals[i].close=iClose(signals[i].symbol,periodBR55,0);
  signals[i].hi=getLow(signals[i].symbol, periodBR55,Period_155,0); //MarketInfo(signals[i].symbol,MODE_HIGH);
  signals[i].lo=getLow(signals[i].symbol, periodBR55,Period_155,0); //MarketInfo(signals[i].symbol,MODE_LOW);
  signals[i].bid=MarketInfo(signals[i].symbol,MODE_BID);
  signals[i].range=(signals[i].hi-signals[i].lo);
  signals[i].shift = iBarShift(signals[i].symbol,PERIOD_M1,TimeCurrent()-periodBR55 * 60);
  signals[i].prevbid = iClose(signals[i].symbol,PERIOD_M1,signals[i].shift);
  
  if(signals[i].range!=0) {            
  signals[i].ratio=MathMin(((signals[i].bid-signals[i].lo)/signals[i].range*100 ),100);
  signals[i].prevratio=MathMin(((signals[i].prevbid-signals[i].lo)/signals[i].range*100 ),100);     
  
  for (int j = 0; j < 8; j++){
  
  if(signals[i].ratio <= 3.0) signals[i].fact = 0;
  if(signals[i].ratio > 3.0)  signals[i].fact = 1;
  if(signals[i].ratio > 10.0) signals[i].fact = 2;
  if(signals[i].ratio > 25.0) signals[i].fact = 3;
  if(signals[i].ratio > 40.0) signals[i].fact = 4;
  if(signals[i].ratio > 50.0) signals[i].fact = 5;
  if(signals[i].ratio > 60.0) signals[i].fact = 6;
  if(signals[i].ratio > 75.0) signals[i].fact = 7;
  if(signals[i].ratio > 90.0) signals[i].fact = 8;
  if(signals[i].ratio > 97.0) signals[i].fact = 9;
  cnt++;
      
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].fact=9-signals[i].fact;
  
  if(curr[j]==StringSubstr(signals[i].symbol,0,3)) 
  {
  signals[i].strength1=signals[i].fact;
  }  
  else
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength2=signals[i].fact;
  }
  signals[i].calc =signals[i].strength1-signals[i].strength2;
  signals[i].strength=currency_strength55(curr[j]);
  if(curr[j]==StringSubstr(signals[i].symbol,0,3))
  {
  signals[i].strength3=signals[i].strength;
  } 
  else
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength4=signals[i].strength;
  }
  signals[i].strength5=(signals[i].strength3-signals[i].strength4);
  signals[i].strength_old55=old_currency_strength55(curr[j]);
  if(curr[j]==StringSubstr(signals[i].symbol,0,3))
  {
  signals[i].strength6=signals[i].strength_old55;
  } 
  else 
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength7=signals[i].strength_old55;
  }
  signals[i].strength8=(signals[i].strength6-signals[i].strength7);     
  signals[i].strength_Gap=signals[i].strength5-signals[i].strength8;
  
  if(signals[i].ratio>=trigger_buy_bidratio)
  {
  signals[i].SigRatio=UP;
  } 
  else 
  {
  if(signals[i].ratio<=trigger_sell_bidratio)
  signals[i].SigRatio=DOWN;
  }  
  
  if(signals[i].ratio>signals[i].prevratio){
  signals[i].SigRatioPrev=UP;
  } 
  else 
  {
  if(signals[i].ratio<signals[i].prevratio)
  signals[i].SigRatioPrev=DOWN;
  }      
  
  if(signals[i].calc>=trigger_buy_relstrength){
  signals[i].SigRelStr=UP;
  } 
  else 
  {
  if (signals[i].calc<=trigger_sell_relstrength) 
  signals[i].SigRelStr=DOWN;
  } 
  
  if(signals[i].strength5>=trigger_buy_buysellratio){
  signals[i].SigBSRatio=UP;
  } 
  else 
  {
  if (signals[i].calc<=trigger_sell_buysellratio) 
  signals[i].SigBSRatio=DOWN;
  }       
  
  if(signals[i].strength_Gap>=trigger_gap_buy){
  signals[i].SigGap=UP;
  } 
  else 
  {
  if (signals[i].strength_Gap<=trigger_gap_sell) 
  signals[i].SigGap=DOWN;
  }
  
  if(signals[i].strength5>signals[i].strength8){
  signals[i].SigGapPrev=UP;
  } 
  else 
  {
  if(signals[i].strength5<signals[i].strength8)      
  signals[i].SigGapPrev=DOWN;
  }  
  }
  }
  }    
  }
//+------------------------------------------------------------------+
double getHigh55(string _symbol, int _tf, int _lookBack, int _shift)
  {
  double high = -500000;
  for (int u = 0; u < _lookBack; u++)
  {
  if (iHigh(_symbol, _tf, _shift+u) > high)
  {
  high = iHigh(_symbol, _tf, _shift+u);
  }
  }
  return high;
  }

double getLow55(string _symbol, int _tf, int _lookBack, int _shift)
  {
  double low = 500000;
  for (int u = 0; u < _lookBack; u++)
  {
  if (iLow(_symbol, _tf, _shift+u) < low)
  {
  low = iLow(_symbol, _tf, _shift+u);
  }
  }
  return low;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
///*sinput*/ string masterPreamble66 = "CM_GVC_TF_10_11";
/*sinput*/ int UpdateInSeconds66  = 1;
/*sinput*/ int xAnchor66 = 420;
/*sinput*/ int yAnchor66 = 10;

///*sinput*/ int TF_1            =30;
/*sinput*/ int Period_166        = 1;

int panelWidth66 = 500;
int panelHeight66 = 400;

int xWidth66 = 50;
int yHeight66 = 11;
int xSpace66 = 1;
int ySpace66 = 5;
color ClrText66 = clrWhiteSmoke;
color ClrBackground66 = clrBlack;
color ClrBorder66 = clrBlack;
int fontSize66 = 7;
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate66(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
  //---
   
  //--- return value of prev_calculated for next call
  return(rates_total);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ 
void displayMeter66() {
   
   double arrt[8][3];
   int arr2,arr3;
   arrt[0][0] = currency_strength66(curr[0]); 
   arrt[1][0] = currency_strength66(curr[1]); 
   arrt[2][0] = currency_strength66(curr[2]);
   arrt[3][0] = currency_strength66(curr[3]); 
   arrt[4][0] = currency_strength66(curr[4]); 
   arrt[5][0] = currency_strength66(curr[5]);
   arrt[6][0] = currency_strength66(curr[6]); 
   arrt[7][0] = currency_strength66(curr[7]);
   arrt[0][2] = old_currency_strength66(curr[0]); 
   arrt[1][2] = old_currency_strength66(curr[1]);
   arrt[2][2] = old_currency_strength66(curr[2]);
   arrt[3][2] = old_currency_strength66(curr[3]); 
   arrt[4][2] = old_currency_strength66(curr[4]);
   arrt[5][2] = old_currency_strength66(curr[5]);
   arrt[6][2] = old_currency_strength66(curr[6]);
   arrt[7][2] = old_currency_strength66(curr[7]);
   arrt[0][1] = 0; arrt[1][1] = 1; arrt[2][1] = 2; arrt[3][1] = 3; arrt[4][1] = 4;arrt[5][1] = 5; arrt[6][1] = 6; arrt[7][1] = 7;
   ArraySort(arrt, WHOLE_ARRAY, 0, MODE_DESCEND);
  
  // set the panel
  //string labelName = masterPreamble66 + "Header";
  
  panelWidth = 1;
  panelWidth = panelWidth + 80;
  
  panelWidth = panelWidth + 3 * xSpace; // + xWidth;
  panelHeight = 9 * yHeight + 10 * ySpace;
  //string panelName = masterPreamble66 + "MainPanel";
  string strText = "(TF: " + IntegerToString(periodBR66,1) + ";  P: " + IntegerToString(Period_166,1) + ")";
  //SetPanel(panelName,0,xAnchor, yAnchor - 20,panelWidth,panelHeight + 20,ClrBackground,clrWhiteSmoke,3);
  //SetText(masterPreamble11 + "_label_indiName","Strength",xAnchor + xSpace,yAnchor - 15,ClrText, fontSize);
  //SetText(masterPreamble11 + "_label_indiName2",strText,xAnchor + xSpace,yAnchor + 5,ClrText, fontSize);
  
  
  for (int m = 0; m < 8; m++) {
  arr2 = arrt[m][1];
  arr3=(int)arrt[m][2];
  currstrength[m] = arrt[m][0];
  prevstrength[m] = arrt[m][2]; 
  SetText(/*masterPreamble66 +*/ curr[arr2]+"pos66",IntegerToString(m+1)+".",xAnchor+697,yAnchor + (m + 1) * (yHeight + ySpace) + 3,color_for_profit66(arrt[m][0]),fontSize);
  SetText(/*masterPreamble66 +*/ curr[arr2]+"curr66", curr[arr2],xAnchor+712,yAnchor + (m+ 1) * (yHeight + ySpace) + 3,color_for_profit66(arrt[m][0]),fontSize);
  SetText(/*masterPreamble66 +*/ curr[arr2]+"currdig66", DoubleToStr(arrt[m][0],1),xAnchor+742,yAnchor + (m + 1) * (yHeight + ySpace) + 3,color_for_profit66(arrt[m][0]),fontSize);
  // SetText(curr[arr2]+"currdig", DoubleToStr(ratio[m][0],1),x_axis+280,(m*18)+y_axis+17,color_for_profit(arrt[m][0]),12);
  
  if(currstrength[m] > prevstrength[m]){SetObjText(/*masterPreamble66 +*/ "Sdir66"+IntegerToString(m),CharToStr(233),xAnchor+763,yAnchor + (m + 1) * (yHeight + ySpace) + 3,BullColor,fontSize);}
  else if(currstrength[m] < prevstrength[m]){SetObjText(/*masterPreamble66 +*/ "Sdir66"+IntegerToString(m),CharToStr(234),xAnchor+763,yAnchor + (m + 1) * (yHeight + ySpace) + 5,BearColor,fontSize);}
  else {SetObjText(/*masterPreamble66 +*/ "Sdir66"+IntegerToString(m),CharToStr(243),xAnchor+763,yAnchor + (m + 1) * (yHeight + ySpace) + 3,clrYellow,fontSize);}
  
  
  }
  ChartRedraw(); 
  }
color color_for_profit66(double total) 
  {
  if(total<2.0)
  return (clrRed);
  if(total<=3.0)
  return (clrOrangeRed);
  if(total>7.0)
  return (clrLime);
  if(total>6.0)
  return (clrGreen);
  if(total>5.0)
  return (clrSandyBrown);
  if(total<=5.0)
  return (clrYellow);       
  return(clrSteelBlue);
  }
  
double currency_strength66(string pair) {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength = 0;
  int cnt1 = 0;
  
  for (int x = 0; x < ArraySize(TradePairs); x++) {
  fact = 0;
  sym = TradePairs[x];
  if (pair == StringSubstr(sym, 0, 3) || pair == StringSubstr(sym, 3, 3)) {
  // sym = sym + tempsym;
  //range = (MarketInfo(sym, MODE_HIGH) - MarketInfo(sym, MODE_LOW)) ;
  range = getHigh(sym, periodBR66,Period_166,0) - getLow(sym, periodBR66,Period_166,0);
  if (range != 0.0) {
  ratio = 100.0 * ((MarketInfo(sym, MODE_BID) - getLow(sym, periodBR66,Period_166,0)) / range );
  if (ratio > 3.0)  fact = 1;
  if (ratio > 10.0) fact = 2;
  if (ratio > 25.0) fact = 3;
  if (ratio > 40.0) fact = 4;
  if (ratio > 50.0) fact = 5;
  if (ratio > 60.0) fact = 6;
  if (ratio > 75.0) fact = 7;
  if (ratio > 90.0) fact = 8;
  if (ratio > 97.0) fact = 9;
  cnt1++;
  if (pair == StringSubstr(sym, 3, 3)) fact = 9 - fact;
  strength += fact;
  // signals[x].strength += fact;
  }
  } 
  
  }
  // for (int x = 0; x < ArraySize(TradePairs); x++) 
  //if(cnt1!=0)signals[x].strength /= cnt1;
  if(cnt1!=0)strength /= cnt1;
  return (strength);
  
  }
//-----------------------------------------------------------------------------------+
double old_currency_strength66(string pair) 
  {
  int fact;
  string sym;
  double range;
  double ratio;
  double strength=0;
  int cnt1=0;
  
  for(int x=0; x<ArraySize(TradePairs); x++) 
  {
  fact= 0;
  sym = TradePairs[x];
  int bar = iBarShift(TradePairs[x],PERIOD_M1,TimeCurrent()-60*periodBR66);
  double prevbid = iClose(TradePairs[x],PERIOD_M1,bar);
  
  if(pair==StringSubstr(sym,0,3) || pair==StringSubstr(sym,3,3)) 
  {
  // sym = sym + tempsym;
  range=(getHigh(sym, periodBR66,Period_166,0)-getLow(sym, periodBR66,Period_166,0));
  if(range!=0.0) 
  {
  ratio=100.0 *((prevbid-getLow(sym, periodBR66,Period_166,0))/range);
  
  if(ratio > 3.0)  fact = 1;
  if(ratio > 10.0) fact = 2;
  if(ratio > 25.0) fact = 3;
  if(ratio > 40.0) fact = 4;
  if(ratio > 50.0) fact = 5;
  if(ratio > 60.0) fact = 6;
  if(ratio > 75.0) fact = 7;
  if(ratio > 90.0) fact = 8;
  if(ratio > 97.0) fact = 9;
  
  cnt1++;
  
  if(pair==StringSubstr(sym,3,3))
  fact= 9-fact;
  
  strength+=fact;
  
  }
  }
  }
  if(cnt1!=0)
  strength/=cnt1;
  
  return (strength);
  
  }
//-----------------------------------------------------------------------------------------------+ 
void GetSignals66() {
  int cnt = 0;
  ArrayResize(signals,ArraySize(TradePairs));
  for (int i=0;i<ArraySize(signals);i++) {
  signals[i].symbol=TradePairs[i]; 
  signals[i].point=MarketInfo(signals[i].symbol,MODE_POINT);
  signals[i].open=iOpen(signals[i].symbol,periodBR66,Period_166);      
  signals[i].close=iClose(signals[i].symbol,periodBR66,0);
  signals[i].hi=getLow(signals[i].symbol, periodBR66,Period_166,0); //MarketInfo(signals[i].symbol,MODE_HIGH);
  signals[i].lo=getLow(signals[i].symbol, periodBR66,Period_166,0); //MarketInfo(signals[i].symbol,MODE_LOW);
  signals[i].bid=MarketInfo(signals[i].symbol,MODE_BID);
  signals[i].range=(signals[i].hi-signals[i].lo);
  signals[i].shift = iBarShift(signals[i].symbol,PERIOD_M1,TimeCurrent()-periodBR66 * 60);
  signals[i].prevbid = iClose(signals[i].symbol,PERIOD_M1,signals[i].shift);
  
  if(signals[i].range!=0) {            
  signals[i].ratio=MathMin(((signals[i].bid-signals[i].lo)/signals[i].range*100 ),100);
  signals[i].prevratio=MathMin(((signals[i].prevbid-signals[i].lo)/signals[i].range*100 ),100);     
           
  for (int j = 0; j < 8; j++){
  
  if(signals[i].ratio <= 3.0) signals[i].fact = 0;
  if(signals[i].ratio > 3.0)  signals[i].fact = 1;
  if(signals[i].ratio > 10.0) signals[i].fact = 2;
  if(signals[i].ratio > 25.0) signals[i].fact = 3;
  if(signals[i].ratio > 40.0) signals[i].fact = 4;
  if(signals[i].ratio > 50.0) signals[i].fact = 5;
  if(signals[i].ratio > 60.0) signals[i].fact = 6;
  if(signals[i].ratio > 75.0) signals[i].fact = 7;
  if(signals[i].ratio > 90.0) signals[i].fact = 8;
  if(signals[i].ratio > 97.0) signals[i].fact = 9;
  cnt++;
  
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].fact=9-signals[i].fact;
  
  if(curr[j]==StringSubstr(signals[i].symbol,0,3)) 
  {
  signals[i].strength1=signals[i].fact;
  }  
  else
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength2=signals[i].fact;
  }
  signals[i].calc =signals[i].strength1-signals[i].strength2;
  signals[i].strength=currency_strength66(curr[j]);
  if(curr[j]==StringSubstr(signals[i].symbol,0,3))
  {
  signals[i].strength3=signals[i].strength;
  } 
  else
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength4=signals[i].strength;
  }
  signals[i].strength5=(signals[i].strength3-signals[i].strength4);
  signals[i].strength_old66=old_currency_strength66(curr[j]);
  if(curr[j]==StringSubstr(signals[i].symbol,0,3))
  {
  signals[i].strength6=signals[i].strength_old66;
  } 
  else 
  {
  if(curr[j]==StringSubstr(signals[i].symbol,3,3))
  signals[i].strength7=signals[i].strength_old66;
  }
  signals[i].strength8=(signals[i].strength6-signals[i].strength7);     
  signals[i].strength_Gap=signals[i].strength5-signals[i].strength8;
  
  if(signals[i].ratio>=trigger_buy_bidratio)
  {
  signals[i].SigRatio=UP;
  } 
  else 
  {
  if(signals[i].ratio<=trigger_sell_bidratio)
  signals[i].SigRatio=DOWN;
  }  
  
  if(signals[i].ratio>signals[i].prevratio){
  signals[i].SigRatioPrev=UP;
  } 
  else 
  {
  if(signals[i].ratio<signals[i].prevratio)
  signals[i].SigRatioPrev=DOWN;
  }      
  
  if(signals[i].calc>=trigger_buy_relstrength){
  signals[i].SigRelStr=UP;
  } 
  else 
  {
  if (signals[i].calc<=trigger_sell_relstrength) 
  signals[i].SigRelStr=DOWN;
  } 
  
  if(signals[i].strength5>=trigger_buy_buysellratio){
  signals[i].SigBSRatio=UP;
  } 
  else 
  {
  if (signals[i].calc<=trigger_sell_buysellratio) 
  signals[i].SigBSRatio=DOWN;
  }       
  
  if(signals[i].strength_Gap>=trigger_gap_buy){
  signals[i].SigGap=UP;
  } 
  else 
  {
  if (signals[i].strength_Gap<=trigger_gap_sell) 
  signals[i].SigGap=DOWN;
  }
  
  if(signals[i].strength5>signals[i].strength8){
  signals[i].SigGapPrev=UP;
  } 
  else 
  {
  if(signals[i].strength5<signals[i].strength8)      
  signals[i].SigGapPrev=DOWN;
  }  
  }
  }
  }    
  }
//+------------------------------------------------------------------+
double getHigh66(string _symbol, int _tf, int _lookBack, int _shift)
  {
  double high = -500000;
  for (int u = 0; u < _lookBack; u++)
  {
  if (iHigh(_symbol, _tf, _shift+u) > high)
  {
  high = iHigh(_symbol, _tf, _shift+u);
  }
  }
  return high;
  }
  
double getLow66(string _symbol, int _tf, int _lookBack, int _shift)
  {
  double low = 500000;
  for (int u = 0; u < _lookBack; u++)
  {
  if (iLow(_symbol, _tf, _shift+u) < low)
  {
  low = iLow(_symbol, _tf, _shift+u);
  }
  }
  return low;
  }

//+------------------------------------------------------------------+

