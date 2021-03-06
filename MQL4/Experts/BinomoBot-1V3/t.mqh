//+------------------------------------------------------------------+
//|                                                            t.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
class t
  {
private:

public:
                     t();
                    ~t();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
t::t()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
t::~t()
  {
  }
//+------------------------------------------------------------------+
/** \brief Поиск индекса криптовалютной пары с наибольшим значением по модулю
 * \param symbol_index Индекс пары
 * \param direction Направление сделки (0 - любое допустимое, 1 - только вверх, 2 - только вниз)
 * \param note Заметка (имя стратегии, индикатора или иное)
 */
void bot_open_order(const int symbol_index, const int direction = 0, const string note = "")
  {
   if(symbol_index == -1)
      return;

   /* получаем значения цены на текущем баре */
   int err = 0;
   err = CopyRates(symbol_indicator[symbol_index], PERIOD_M1, 0, 1, rates);
   if(err == 0)
     {
      Print("Ошибка! Не удалось загрузить массив цен символа ", symbol_indicator[symbol_index]);
      return;
     }
   else
      if(ArraySize(rates) == 0)
        {
         Print("Ошибка! Массив цен символа ", symbol_indicator[symbol_index]," имеет нулевую длину");
         return;
        }

   /* защищаем советник от открытия сделок "в прошлом" */
   if(rates[0].time < init_time)
     {
      if(!is_open_past_order)
        {
         Print("Ошибка! Советник пытается октрыть сделоку <в прошлом>, символ ",
               symbol_indicator[symbol_index],
               " дата бара ", TimeToStr(rates[0].time),
               " дата ", TimeToStr(init_time));
        }
      is_open_past_order = true;
      return;
     }
   else
     {
      is_open_past_order = false;
     }

   /* получаем цены текущего бара */
   const double close = rates[0].close;
   const double open = rates[0].open;

   int tpips = take_profit_pips;
   int spips = stop_loss_pips;
   if(use_procent)
     {
      /* Значения Стопа и Тейка не в пунктах, а в % */
      const int digits = (int)MarketInfo(symbol_indicator[symbol_index], MODE_DIGITS);
      const double coeff = MathPow(10, digits);

      int price_pips =  coeff == 0 ? 0 : (int)(close / (1.0 / coeff));
      tpips = take_profit_procent == 0 ? 0 : (price_pips * 100) / take_profit_procent;
      spips = stop_loss_procent == 0 ? 0 : (price_pips * 100) / stop_loss_procent;
     }

   /* Если текущая свеча медвежья, то открывается сделка вверх */
   if(close < open && direction >= 0)
     {
      if(api.open_order_v3(symbol_indicator[symbol_index], note, LONG, expiration, user_quantity, tpips, spips))
        {
         is_open_order = true;
         Print("ордер: ", symbol_indicator[symbol_index], " LONG");
        }
      else
        {
         Print("Ошибка! ордер не был открыт: ", symbol_indicator[symbol_index], " LONG");
        }
     }
   else
      /* Если свеча бычья, то сделка вниз */
      if(close > open && direction <= 0)
        {
         if(api.open_order_v3(symbol_indicator[symbol_index], note, SHORT, expiration, user_quantity, tpips, spips))
           {
            is_open_order = true;
            Print("ордер: ", symbol_indicator[symbol_index], " SHORT");
           }
         else
           {
            Print("Ошибка! ордер не был открыт: ", symbol_indicator[symbol_index], " LONG");
           }
        }
  }
//+------------------------------------------------------------------+
