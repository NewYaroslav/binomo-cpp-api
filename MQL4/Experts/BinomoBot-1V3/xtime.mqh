//+------------------------------------------------------------------+
//|                                                        xtime.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

class xtime {
private:

public:
   xtime() {};
   ~xtime() {};
   
    /// Количество секунд в минуте, часе и т.д.
    enum {
        SECONDS_IN_MINUTE = 60,	            ///< Количество секунд в одной минуте
        SECONDS_IN_HALF_HOUR = 1800,        ///< Количество секунд в получасе
        SECONDS_IN_HOUR = 3600,	            ///< Количество секунд в одном часе
        SECONDS_IN_DAY = 86400,	            ///< Количество секунд в одном дне
        SECONDS_IN_YEAR = 31536000,	        ///< Количество секунд за год
        SECONDS_IN_LEAP_YEAR = 31622400,	///< Количество секунд за високосный год
        AVERAGE_SECONDS_IN_YEAR = 31557600, ///< Среднее количество секунд за год
        SECONDS_IN_4_YEAR = 126230400,	    ///< Количество секунд за 4 года
        MINUTES_IN_HOUR = 60,               ///< Количество минут в одном часе
        MINUTES_IN_DAY = 1440,              ///< Количество минут в одном дне
        HOURS_IN_DAY = 24,                  ///< Количество часов в одном дне
        MONTHS_IN_YEAR = 12,                ///< Количество месяцев в году
        DAYS_IN_WEEK = 7,                   ///< Количество дней в неделе
        DAYS_IN_LEAP_YEAR = 366,            ///< Количество дней в високосом году
        DAYS_IN_YEAR = 365,                 ///< Количество дней в году
        DAYS_IN_4_YEAR = 1461,              ///< Количество дней за 4 года
        FIRST_YEAR_UNIX = 1970,             ///< Год начала UNIX времени
        MAX_DAY_MONTH = 31,                 ///< Максимальное количество дней в месяце
        OADATE_UNIX_EPOCH = 25569,          ///< Дата автоматизации OLE с момента эпохи UNIX
    };
   
    /** \brief Получить час дня
     * Данная функция вернет от 0 до 23 (час дня)
     * \param timestamp метка времени
     * \return час дня
     */
    static inline uint get_hour_day(const datetime timestamp) {
            return (uint)(((ulong)timestamp / SECONDS_IN_HOUR) % HOURS_IN_DAY);
    }
    
    /** \brief Получить минуту дня
     *
     * Данная функция вернет от 0 до 1439 (минуту дня)
     * \param timestamp метка времени
     * \return минута дня
     */
    static inline uint get_minute_day(const datetime timestamp) {
            return (uint)(((ulong)timestamp / SECONDS_IN_MINUTE) % MINUTES_IN_DAY);
    }

    /** \brief Получить минуту часа
     *
     * Данная функция вернет от 0 до 59
     * \param timestamp метка времени
     * \return Минута часа
     */
    static inline uint get_minute_hour(const datetime timestamp) {
            return (uint)(((ulong)timestamp / SECONDS_IN_MINUTE) % MINUTES_IN_HOUR);
    }
    
    /** \brief Получить секунду дня
     *
     * Данная функция вернет от 0 до 86399
     * \param timestamp метка времени
     * \return секунда дня
     */
    static inline uint get_second_day(const datetime timestamp) {
            return (uint)((ulong)timestamp % SECONDS_IN_DAY);
    }
};
