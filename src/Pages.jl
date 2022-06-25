function make_header(uri::String = "/images/animated.gif")
    header = divider("header", align = "center", float = "left")
    header["top-margin"] = "100px"
    logo = img("logo", src = uri)
    logo[:class] = "logo"
    push!(header, logo)
    header
end


function home(c::Connection)
    write!(c, title("thetitle", text = "em's computer!"))
    header = make_header()

    #==
    Header links
    ==#
    main = divider("maindiv")
    main["dark"] = "no"
    style!(main, "background-color" => "#03DAC6", "margin-top" => "50px",
    "border-radius" => "20px", "padding" => "10px")
    sponsorbttn = img("sponsorbutton", src = "images/icons/sponsoricon.png",
    width = 64, height = 64)
    githubbttn = img("ghbutton", src = "images/icons/ghicon.png",
    width = 64, height = 64)
    ytbttn = img("ytbutton", src = "images/icons/yticon.png",
    width = 64, height = 64)
    medbttn = img("medbutton", src = "images/icons/medic.png",
    width = 64, height = 64)
    lightbttn = img("lightbutton", src = "images/icons/swicol.png")
    linkbuttons = components(sponsorbttn, githubbttn, ytbttn, medbttn, lightbttn)
    for thisbutton in linkbuttons
        on(c, thisbutton, "mouseover") do cm::ComponentModifier
            cm[thisbutton] = "width" => 75
            cm[thisbutton] = "height" => 75
        end
        on(c, thisbutton, "mouseleave") do cm::ComponentModifier
            cm[thisbutton] = "width" => 64
            cm[thisbutton] = "height" => 64
        end
    end
    on(c, sponsorbttn, "click") do cm::ComponentModifier
        redirect!(cm, "https://github.com/sponsors/emmettgb")
        alert!(cm, "redirecting to my sponsors profile (thanks!)")
    end
    on(c, medbttn, "click") do cm::ComponentModifier
        redirect!(cm, "https://medium.com/@emmettgb")
        alert!(cm, "redirecting to my medium blog :)")
    end
    on(c, ytbttn, "click") do cm::ComponentModifier
        redirect!(cm, "https://www.youtube.com/channel/UCruzXIngBV2dlgjX1_HZRzw")
        alert!(cm, "redirecting to my youtube channel!")
    end
    on(c, githubbttn, "click") do cm::ComponentModifier
        redirect!(cm, "https://github.com/emmettgb")
        alert!(cm, "redirecting to my github!")
    end
    on(c, lightbttn, "click") do cm::ComponentModifier
        if cm[main]["dark"] != "yes"
            cm[lightbttn] = "src" => "/images/icons/swicold.png"
            style!(cm, main, "background-color" => "#3700B3")
            cm[main] = "dark" => "yes"
        else
            cm[lightbttn] = "src" => "/images/icons/swicol.png"
            style!(cm, main, "background-color" => "#03DAC6")
            cm[main] = "dark" => "no"
        end
    end
    #==
    /Header links
    ==#
    repobutton = button("repobutton", text = "repository overview")
    style!(repobutton, "color" => "white", "border-style" => "none",
    "background-color" => "#107896", "border-radius" => "10px")
    on(c, repobutton, "click") do cm::ComponentModifier
        cm["logo"] = "src" => "/images/animated.gif"
    end
    on(c, repobutton, "mouseover") do cm::ComponentModifier
        style!(cm, repobutton, "background-color" => "lightblue")
    end
    on(c, repobutton, "mouseleave") do cm::ComponentModifier
        style!(cm, repobutton, "background-color" => "#107896")
    end
     button_group = divider("buttongrp", align = "center")
     push!(button_group, sponsorbttn, githubbttn, ytbttn, medbttn, lightbttn)
     push!(main, repobutton)
    write!(c, stylesheet())
    write!(c, header)
    write!(c, button_group)
    write!(c, main)
end
