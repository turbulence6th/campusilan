// Define the tour!
    var tour = {
      id: "hello-hopscotch",
      steps: [
      
      	{
          title: "Giriş & Kayıt",
          content: "Buradan giriş yapabilir yada üye değilseniz üye olabilirsiniz.",
          target: "birincikisim",
          placement: "left"
          
       },
        {
          title: "Kategoriler ve Fırsatlar",
          content: "Bu bölümden ilan kategorilerine ve fırsatlara ulaşabilirsiniz.",
          target: "ikincikisim",
          placement: "right"
          
        },
        {
          title: "Günün Fırsatları",
          content: "Bu bölümden günün fırsatlarını hızlıca görebilirsiniz",
          target: 'ucuncukisim',
          placement: "left"
        },
        {
          title: "Acil İlanlar",
          content: "Buradan acil ilanları hızlıca görebilirsiniz",
          target: 'dorduncukisim',
          placement: "top"
        },
        {
          title: "En Son İlanlar",
          content: "Buradan en son eklenen ilanlara kolayca ulaşabilirsiniz",
          target: '5.kisim',
          placement: "top",
          xOffset: "center"
        },
        {
          title: "En Popüler İlanlar",
          content: "Buradan sitedeki en çok ziyaret edilen ilanları görebilirsiniz.",
          target: '6.kisim',
          placement: "top",
          xOffset: "center"
        },
        {
          title: "En Güvenilir Satıcılar",
          content: "Buradan daha önceki ziyaretçilerin oylarına göre en güvenilir satıcılara kolayca ulaşın.",
          target: 'yedincikisim',
          placement: "top",
          xOffset: "center",
          
          multipage: true,
              onNext: function() {
                window.location = "/kategoriler";
              }
        },
        {
          title: "Tüm İlan Kategorileri",
          content: "Buradan Campus İlan'daki tüm ilan kategorilerini görün.",
          target:'sekizincikisim',
          placement: "bottom",
          multipage: true,
              onNext: function() {
                window.location = "/firsatlar";
              }
          
          
        },
        {
          title: "Fırsatlar",
          content: "Buradan çeşitli fırsatlara ulaşabilirsiniz.",
          target:'dokuzuncukisim',
          placement: "bottom",
          multipage: true,
              onNext: function() {
                window.location = "/universiteler";
              }
          
          
        },
        {
          title: "Üniversitenizi Seçin",
          content: "İlanlarına bakmak istediğiniz üniversiteyi buradan seçebilirsiniz.",
          target:'onuncukisim',
          placement: "bottom",
          
          
          
        },
        {
          title: "Üniversitenin İlanları",
          content: "Seçtiğiniz üniversitenin ilanları burada listelenecektir.",
          target:'onbirincikisim',
          placement: "top",
          multipage: true,
              onNext: function() {
                window.location = "/aramasonuclari";
              }
          
          
        },
        {
          title: "Arama Paneli",
          content: "Buradan arama kriterlerinizi belirleyiniz.",
          target:'onikincikisim',
          placement: "right",
          
          
          
        },
        {
          title: "Arama Paneli",
          content: "Arama kriterlerinizi belirledikten sonra buradan aramak istediğiniz ilanın adını girip 'Ara' butonuna tıklayınız.",
          target:'onucuncukisim',
          placement: "right",
           multipage: true,
              onNext: function() {
                window.location = "/";
              }
          
          
          
        },
        {
          title: "Hepsi bu kadar",
          content: "Campus İlan Tanıtıcısını başarıyla tamamladınız.Sitemizde keyifli gezinmeler :) ",
          target:'ondorduncukisim',
          placement: "bottom"
          
          
          
        }
        
      ],
       showPrevButton: true
    };

    // Start the tour!
  
        
