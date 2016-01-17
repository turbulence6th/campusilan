// Define the tour!
    var tour = {
      id: "hello-hopscotch",
      steps: [
        {
          title: "My Header",
          content: "This is the header of my page.",
          target: "ilkkisim",
          placement: "right"
        },
        {
          title: "My content",
          content: "Here is where I put my content.",
          target: document.querySelector("#content p"),
          placement: "bottom"
        }
      ]
    };

    // Start the tour!
    hopscotch.startTour(tour);
        
That's all there is to it!

Defining a Tour
A Hopscotch tour consists of a tour id, an array of tour steps defined as JSON objects, and a number of tour-specific options. The tour id is simply a unique identifier string. The simplest tour consists of just an id string and an array of one or more steps.

Basic step options
The step options below are the most basic options.

Note that title and content are both optional only because you can choose to have a step with only a title, only content, or both title and content.

This is an example of a tour defined with only basic steps.


    {
      id: "welcome_tour",
      steps: [
        {
          target: "header",
          placement: "bottom",
          title: "This is the navigation menu",
          content: "Use the links here to get around on our site!"
        },
        {
          target: "profile-pic",
          placement: "right",
          title: "Your profile picture",
          content: "Upload a profile picture here."
        },
        {
          target: "inbox",
          placement: "bottom",
          title: "Your inbox",
          content: "Messages from other users will appear here."
        }
      ]
    }
    


 // Start the tour!
    hopscotch.startTour(tour);