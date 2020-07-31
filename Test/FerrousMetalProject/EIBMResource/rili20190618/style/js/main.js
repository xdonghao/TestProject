(function(e, t) {
    typeof define == "function" && define.amd ? define("common", ["require", "exports", "module", "jquery"],
    function(n, r, i) {
        var s = n("jquery");
        return t(e, s)
    }) : e.JINCommon = t(e, e.jQuery)
})(this,
function(e, t) {
    var n = {
        set: function(e, t, n, r, i, s) {
            var o = e + "=" + encodeURIComponent(t);
            n != null && (o += "; expires=" + n),
            r != null && (o += "; path=" + r),
            i != null && (o += "; domain=" + i),
            s != null && (o += "; secure=" + s),
            document.cookie = o
        },
        get: function(e) {
            var t = document.cookie.split("; ");
            for (var n = 0; n < t.length; n++) {
                var r = t[n].split("=");
                if (e == r[0]) return decodeURIComponent(r[1])
            }
            return ""
        },
        remove: function(e, t, n) {
            this.get(e) && (document.cookie = e + "=" + (t ? ";path=" + t: "") + (n ? ";domain=" + n: "") + ";expires=Thu, 01 Jan 1970 00:00:01 GMT")
        }
    },
    r = function() {
        var e = navigator.userAgent,
        t = /Android\s+([\d.]+)/.test(e),
        n = /(?:iPad|iPhone).*OS\s([\d_]+)/.test(e) && !t,
        r = t || n,
        i = /micromessenger/.test(e.toLowerCase());
        return {
            isAndroid: t,
            isIos: n,
            isMobile: t || n,
            isWeixin: i
        }
    };
    return {
        cookie: n,
        device: r()
    }
}),
function(e, t) {
    typeof define == "function" && define.amd ? define("jsBridge", ["require", "exports", "module", "common"],
    function(n, r, i) {
        var s = n("common");
        return t(e, s)
    }) : e.JSBridge = t(e, e.JINCommon)
} (this,
function(e, t) {
    function r(e) {
        var t = document.createElement("iframe");
        t.style.width = "1px",
        t.style.height = "1px",
        t.style.display = "none",
        t.src = e,
        document.body.appendChild(t),
        setTimeout(function() {
            t.remove()
        },
        100)
    }
    function i(e) {
        var t = e || location.search,
        n = t && /^\?/.test(t) ? t.slice(1) : t,
        r = {},
        i = n.split("&");
        if (!n) return ! 1;
        for (var s = 0,
        o = i.length; s < o; s++) {
            var u = i[s].split("=");
            r[u[0]] = u[1]
        }
        return r
    }
    function s() {
        this.http = "js-call://";
        var e = this.getUri(),
        n = "";
        e && (n = e.device),
        this.oauthType = sessionStorage.getItem("IS_APP");
        if (this.oauthType !== null) return this.isApp = !0,
        !1;
        this.isApp = typeof IS_APP != "undefined" || n || location.href.indexOf("device=iOS") !== -1 || location.href.indexOf("device=android") !== -1 ? !0 : !1,
        this.isPcApp = this.isApp && !t.device.isMobile;
        var r = window._dsbridge,
        s = !1;
        if (typeof r != "undefined") var s = r.call && !!r.call("comm.isAndroid", '{"data": null}');
        var o = !!window.webkit && !!window.webkit.messageHandlers && typeof window.webkit.messageHandlers.getAppUserInfos != "undefined";
        if (s || o) this.isApp = !0,
        this.isNewApp = !0;
        if (this.isApp && t.device.isMobile) {
            var u = i().oauth;
            u || (u = 1)
        }
    }
    var n = null;
    typeof window.Jin10JSBridge != "undefined" && (n = new Jin10JSBridge),
    s.prototype.getData = function(e, t) {
        var n = this.http + e;
        r(n)
    },
    s.prototype.putData = function(e, t) {
        var n = this.http + e,
        i = [];
        for (var s in t) i.push(s + "=" + t[s]);
        n += "?" + i.join("&"),
        r(n)
    },
    s.prototype.getUri = function() {
        return i()
    },
    s.prototype.getOauth = function() {
        var e = i(),
        t = [];
        return e && e.oauth ? t = e.oauth.split(",") : t = this.oauthType == 1 || !this.oauthType ? [] : this.oauthType.split(","),
        t
    },
    s.prototype.login = function() {
        if (n) return n.login(),
        !1;
        this.isNewApp ? window.webkit.messageHandlers.openAppLoginView.postMessage("") : this.getData("user/login")
    },
    s.prototype.logout = function() {
        if (n) return n.logout(),
        !1;
        this.isNewApp ? window.webkit.messageHandlers.appLogOut.postMessage("") : this.getData("user/logout")
    };
    var o = new s;
    return o
}),
function(e, t) {
    typeof define == "function" && define.amd ? define("slider", ["require", "exports", "module", "jquery"],
    function(e, n, r) {
        var i = e("jquery");
        return t(i)
    }) : t(e.jQuery)
} (this,
function(e) {
    e.support.transition = function() {
        var e = function() {
            var e = document.createElement("bootstrap"),
            t = {
                WebkitTransition: "webkitTransitionEnd",
                MozTransition: "transitionend",
                OTransition: "oTransitionEnd otransitionend",
                transition: "transitionend"
            },
            n;
            for (n in t) if (e.style[n] !== undefined) return typeof IS_APP != "undefined" ? !1 : t[n];
            return ! 1
        } ();
        return e && {
            end: e
        }
    } (),
    e.fn.emulateTransitionEnd = function(t) {
        var n = !1,
        r = this;
        e(this).one(e.support.transition.end,
        function() {
            n = !0
        });
        var i = function() {
            n || e(r).trigger(e.support.transition.end)
        };
        return setTimeout(i, t),
        this
    };
    var t = function(t, n) {
        this.$element = e(t),
        this.$indicators = this.$element.find(".carousel-indicators"),
        this.options = n,
        this.paused = null,
        this.sliding = null,
        this.interval = null,
        this.$active = null,
        this.$items = null,
        this.options.pause == "hover" && !("ontouchstart" in document.documentElement) && this.$element.on("mouseenter.uc.carousel", e.proxy(this.pause, this)).on("mouseleave.uc.carousel", e.proxy(this.cycle, this))
    };
    t.TRANSITION_DURATION = 600,
    t.DEFAULTS = {
        interval: 5e3,
        pause: "hover",
        wrap: !0
    },
    t.prototype.cycle = function(t) {
        return t || (this.paused = !1),
        this.interval && clearInterval(this.interval),
        this.options.interval && !this.paused && (this.interval = setInterval(e.proxy(this.next, this), this.options.interval)),
        this
    },
    t.prototype.getItemIndex = function(e) {
        return this.$items = e.parent().children(".ucItem"),
        this.$items.index(e || this.$active)
    },
    t.prototype.getItemForDirection = function(e, t) {
        var n = this.getItemIndex(t),
        r = e == "prev" && n === 0 || e == "next" && n == this.$items.length - 1;
        if (r && !this.options.wrap) return t;
        var i = e == "prev" ? -1 : 1,
        s = (n + i) % this.$items.length;
        return this.$items.eq(s)
    },
    t.prototype.to = function(e) {
        var t = this,
        n = this.getItemIndex(this.$active = this.$element.find(".ucItem.active"));
        if (e > this.$items.length - 1 || e < 0) return;
        return this.sliding ? this.$element.one("slid.uc.carousel",
        function() {
            t.to(e)
        }) : n == e ? this.pause().cycle() : this.slide(e > n ? "next": "prev", this.$items.eq(e))
    },
    t.prototype.pause = function(t) {
        return t || (this.paused = !0),
        this.$element.find(".next, .prev").length && e.support.transition && (this.$element.trigger(e.support.transition.end), this.cycle(!0)),
        this.interval = clearInterval(this.interval),
        this
    },
    t.prototype.next = function() {
        if (this.sliding) return;
        return this.slide("next")
    },
    t.prototype.prev = function() {
        if (this.sliding) return;
        return this.slide("prev")
    },
    t.prototype.slide = function(n, r) {
        var i = this.$element.find(".ucItem.active"),
        s = r || this.getItemForDirection(n, i),
        o = this.interval,
        u = n == "next" ? "left": "right",
        a = this;
        if (s.hasClass("active")) return this.sliding = !1;
        var f = s[0],
        l = e.Event("slide.uc.carousel", {
            relatedTarget: f,
            direction: u
        });
        this.$element.trigger(l);
        if (l.isDefaultPrevented()) return;
        this.sliding = !0,
        o && this.pause();
        if (this.$indicators.length) {
            this.$indicators.find(".active").removeClass("active");
            var c = e(this.$indicators.children()[this.getItemIndex(s)]);
            c && c.addClass("active")
        }
        var h = e.Event("slid.uc.carousel", {
            relatedTarget: f,
            direction: u
        });
        return e.support.transition && this.$element.hasClass("ucSlide") ? (s.addClass(n), s[0].offsetWidth, i.addClass(u), s.addClass(u), i.one(e.support.transition.end,
        function() {
            s.removeClass([n, u].join(" ")).addClass("active"),
            i.removeClass(["active", u].join(" ")),
            a.sliding = !1,
            setTimeout(function() {
                a.$element.trigger(h)
            },
            0)
        }).emulateTransitionEnd(t.TRANSITION_DURATION)) : (i.removeClass("active"), s.addClass("active"), this.sliding = !1, this.$element.trigger(h)),
        o && this.cycle(),
        this
    },
    e.fn.slider = function(n) {
        return this.each(function() {
            var r = e(this),
            i = r.data("uc.carousel"),
            s = e.extend({},
            t.DEFAULTS, r.data(), typeof n == "object" && n),
            o = typeof n == "string" ? n: s.slide;
            i || r.data("uc.carousel", i = new t(this, s)),
            typeof n == "number" ? i.to(n) : o ? i[o]() : s.interval && i.pause().cycle()
        })
    },
    e.fn.slider.Constructor = t
}),
function(e, t) {
    if (typeof define == "function" && define.amd) define("userModal", ["require", "exports", "module", "jquery", "jsBridge", "common", "slider"],
    function(n, r, i) {
        var s = n("jquery"),
        o = n("jsBridge"),
        u = n("common");
        return n("slider"),
        t(e, s, o, u)
    });
    else if (typeof exports == "object") {
        var n = require("jquery"),
        r = require("jsBridge"),
        i = require("common");
        module.exports = t(e, n, r, i)
    } else e.UserModal = t(e, e.jQuery, e.JSBridge, e.JINCommon)
} (this,
function(e, t, n, r) {
    function o(e) {
        var n = t("#J_userModal");
        this.firstRender = !0,
        this.target = "default",
        this.options = {},
        this.options.showMask = !0,
        t.extend(this.options, e),
        n.length ? (this.firstRender = !1, this.userModalDom = n, this.userModalWrapDom = t("#J_userModalWrap"), this.userModalListDom = t("#J_userModalList"), this.userModal_reset = t("#J_userModalReset"), this.userModal_login = t("#J_userModalLogin"), this.userModal_register = t("#J_userModalRegister"), this.userModal_bind = t("#J_userModalBind"), this.userModal_oauth = t("#J_userModalOauth")) : (this.userModalDom = t(i.con), this.userModalWrapDom = t(i.wrap), this.userModalListDom = t(i.listWrap), this.userModal_reset = t(i.reset), this.userModal_login = t(i.login), this.userModal_register = t(i.register), this.userModal_bind = t(i.bind), this.userModal_oauth = t(i.oauth))
    }
    function u(e) {
        return '<div class="user-modal-main"><div class="user-modal-content"><span><img src="style/assets/img/icon-gif.gif">正在跳转</span><iframe scrolling="auto" allowtransparency="true" class="user-modal-oauthFrame" frameborder="0" src="' + e.src + '"></iframe>' + '<div class="user-modal-footer">' + '<a data-target="#J_userModalWrap" class="user-modal-jumpLeft" data-ucenterSlide-to="1">返回登录</a>' + "</div>"
    }
    function a(e) {
        return '<div class="user-modal-header"><h3>' + e + "</h3>" + '<a href="javascript:;" class="user-modal-close J_userModalClose">&times;</a>' + "</div>"
    }
    function f() {
        var e = r.device.isWeixin ? "": "",
        t = {
            weibo: '<a class="user-social-btn user-social-weibo" data-href="style/oauth/weibo" data-target="weibo"><i></i></a>',
            qq: '<a class="user-social-btn user-social-qq" data-href="style/oauth/qq" data-target="qq"><i></i></a>',
            weixin: '<a class="user-social-btn user-social-weixin" data-href="' + e + '" data-target="weixin"><i></i></a>'
        },
        i = ["weibo", "qq", "weixin"],
        s = "";
        r.device.isMobile && !r.device.isWeixin && (i = ["weibo", "qq"]);
        if (n.isApp) var i = n.getOauth();
        if (!i.length) return ! 1;
        for (var o = 0,
        u = i.length; o < u; o++) s += t[i[o]];
        return s
    }
    var i = {
        con: '<div id="J_userModal" class="user-modal"></div>',
        wrap: '<div id="J_userModalWrap" class="user-modal-wrap ucCarousel ucSlide" data-ride="carousel"></div>',
        listWrap: '<div id="J_userModalList" class="user-modal-list"></div>',
        reset: '<div id="J_userModalReset" class="user-modal-item user-modal-reset ucItem"></div>',
        login: '<div id="J_userModalLogin" class="user-modal-item user-modal-login ucItem"></div>',
        register: '<div id="J_userModalRegister" class="user-modal-item user-modal-register ucItem"></div>',
        bind: '<div id="J_userModalBind" class="user-modal-item user-modal-bind ucItem"></div>',
        oauth: '<div id="J_userModalOauth" class="user-modal-item user-modal-oauth ucItem"></div>'
    },
    s = {};
    o.prototype.render = function() {
        return this.firstRender ? (this.userModal_reset.append(s.reset), this.userModal_login.append(s.login), this.userModal_register.append(s.register), this.userModal_bind.append(s.bind), this.userModalListDom.append(this.userModal_reset), this.userModalListDom.append(this.userModal_login), this.userModalListDom.append(this.userModal_register), this.userModalListDom.append(this.userModal_oauth), this.userModalListDom.append(this.userModal_bind), this.userModalWrapDom.append(this.userModalListDom), this.userModalDom.append(this.userModalWrapDom), t("body").append(this.userModalDom), this.options.showMask || this.userModalDom.css({
            background: "none",
            filter: "none"
        }), this) : !1
    },
    o.prototype.show = function(e) {
        this.userModalDom.addClass("show"),
        e = e || "login",
        this["userModal_" + e].addClass("active");
        var t = new Date;
        t.setTime(t.getTime() + 2592e6),
        r.cookie.set("oauthBackUrl", location.href, t.toGMTString(), "/", "table.com")
    },
    o.prototype.hide = function(e) {
        var n = this,
        r = function() {
            n.userModalDom.removeClass("show"),
            setTimeout(function() {
                t.each(["login", "reset", "register", "oauth"],
                function(e, t) {
                    n["userModal_" + t].removeClass("active")
                })
            },
            300)
        };
        e ? setTimeout(function() {
            r()
        },
        e) : r()
    },
    o.prototype.createOauthFrame = function(e) {
        this.userModal_oauth.html(u({
            src: e,
            height: 500,
            width: 500
        }))
    },
    o.prototype.bindEvents = function() {
        var e = this;
        this.userModalDom.on("click", ".J_userModalClose",
        function() {
            e.hide()
        });
        var i = this.userModalWrapDom,
        s = function(n) {
            var r, s = t(this);
            if (!i.hasClass("ucCarousel")) return;
            var o = t.extend({},
            i.data(), s.data()),
            u = s.attr("data-ucenterSlide-to");
            u == 2 && setTimeout(function() {
                e.userModal_register.find(".J_imgCaptcha").trigger("click")
            },
            100),
            u && (o.interval = !1),
            i.slider(o),
            u && i.data("uc.carousel").to(u),
            e.target = "default",
            n.preventDefault()
        };
        this.userModalDom.on("click", "[data-ucenterSlide-to]", s),
        this.userModalDom.find(".user-social-body").on("click", "a",
        function() {
            var s = t(this),
            o = s.data("href"),
            u = s.data("target");
            e.target = u;
            if (n.isApp && r.device.isMobile) return n.putData("login/oauth", {
                type: u
            }),
            !1;
            if (u === "weixin" || r.device.isMobile && u === "qq") {
                var a = 400,
                f = 500,
                l = t(window),
                c = (l.height() - f) / 2,
                h = (l.width() - a) / 2;
                return r.device.isWeixin || u === "qq" ? location.href = o: window.open(o, "oauthWeixinWindow", "height=" + f + ", width=" + a + ", top=" + c + ", left=" + h + ", toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no"),
                !1
            }
            e.createOauthFrame(o),
            i.slider({
                ride: "carousel",
                slideTo: 3,
                target: "#J_userModalWrap",
                interval: !1
            }),
            i.data("uc.carousel").to(3)
        }),
        this.options.showMask ? (this.userModalDom.on("click",
        function(n) {
            var r = t(n.target);
            r.closest(".user-modal-main").length == 0 && e.hide()
        }), this.userModalDom.find(".user-modal-logo").hide()) : t(".J_userModalClose").hide()
    },
    o.prototype.init = function() {
        return this.render(),
        this.bindEvents(),
        this
    };
    var l = f();
    return s.social = '<div class="user-social-body">' + l + "</div>",
    s.logo = '<div class="user-modal-logo"></div>',
    s.reset = '<div class="user-modal-main">' + s.logo + '<div class="user-modal-content">' + a("重新设置密码") + '<div class="user-modal-body">' + '<form id="J_resetForm" class="user-form" action="" method="post">' + '<div class="user-form-group">' + '<label for="J_phoneForget" style="display: none;">手机号 </label>' + '<input type="tel" name="phone" id="J_phoneForget" class="user-form-input J_phoneNum" placeholder="请输入您的手机号" required>' + "</div>" + '<div class="user-form-group user-form-verifycode">' + '<label for="J_resetVerifyCode" style="display: none;">手机验证码 </label>' + '<input type="text" name="code" id="J_resetVerifyCode" class="user-form-input J_phoneCode" placeholder="请输入手机验证码" size="6" required autocomplete="off" pattern="^\\d{6}$">' + '<a href="javascript:;" class="user-button user-form-codeBtn J_sendCode">获取验证码</a>' + "</div>" + '<div class="user-form-group">' + '<label for="J_resetPassword" style="display: none;">密码 </label>' + '<input type="password" name="password" id="J_resetPassword" class="user-form-input J_password" placeholder="密码" required size="32" data-min="6" data-max="32">' + "</div>" + '<div class="user-form-footer">' + '<button class="user-button user-button-custom" type="submit">修改密码</button>' + "</div>" + "</form>" + "</div>" + '<div class="user-modal-footer">' + '<a data-target="#J_userModalWrap" class="user-modal-jumpLeft" data-ucenterSlide-to="1">返回登录</a>' + '<a data-target="#J_userModalWrap" class="user-modal-jumpRight J_sliderBtn" data-ucenterSlide-to="2">注册</a>' + "</div>" + "</div>" + "</div>",
    s.login = '<div class="user-modal-main">' + s.logo + '<div class="user-modal-content">' + a("登录帐号") + '<div class="user-modal-body">' + '<form id="J_loginForm" class="user-form" action="" method="post">' + '<div class="user-form-group">' + '<label for="J_loginPhone" style="display: none;">手机号 </label>' + '<input type="tel" name="username" id="J_loginPhone" class="user-form-input J_phoneNum" placeholder="请输入手机号"  required>' + "</div>" + '<div class="user-form-group">' + '<label for="J_loginPassword" style="display: none;">密码 </label>' + '<input type="password" name="password" id="J_loginPassword" class="user-form-input J_password" placeholder="密码" required size="32" data-max="32">' + "</div>" + '<div class="user-form-group user-form-verifycode d-hide">' + '<label for="J_loginVerifyCode" style="display: none;">验证码 </label>' + '<input type="text" name="code" id="J_loginVerifyCode" class="user-form-input J_verifyCode" placeholder="请输入验证码" autocomplete="off">' + '<a href="javascript:;" class="user-form-codeImg J_imgCaptcha"><img></a>' + "</div>" + "<!-- 登录 -->" + '<div class="user-form-footer">' + '<button class="user-button user-button-custom" type="submit">登录</button>' + "</div>" + "</form>" + "<!-- 第三方登录 -->" + (l ? '<div class="user-social"><div class="user-social-header"><span>使用社交帐号登录</span></div>' + s.social + "</div>": "") + "</div>" + '<div class="user-modal-footer">' + '<a data-target="#J_userModalWrap" class="user-modal-jumpLeft" data-ucenterSlide-to="0">忘记密码</a>' + '<a data-target="#J_userModalWrap" class="user-modal-jumpRight" data-ucenterSlide-to="2">注册</a>' + "</div>" + "</div>" + "</div>",
    s.register = '<div class="user-modal-main">' + s.logo + '<div class="user-modal-content">' + a("注册帐号") + '<div class="user-modal-body">' + '<form id="J_registerForm" class="user-form" action="" method="post">' + '<div class="user-form-group">' + '<label for="J_registerPhone" style="display: none;">手机号 </label>' + '<input type="tel" name="phone" id="J_registerPhone" class="user-form-input J_phoneNum" placeholder="请输入您的手机号" required>' + "</div>" + '<div class="user-form-group user-form-verifycode">' + '<label for="J_registerPhoneCode" style="display: none;">手机验证码 </label>' + '<input type="text" name="code" id="J_registerPhoneCode" class="user-form-input J_phoneCode" placeholder="请输入手机验证码" size="6" required  pattern="^\\d{6}$" autocomplete="off">' + '<a href="javascript:;" class="user-button user-form-codeBtn J_sendCode">获取验证码</a>' + "</div>" + '<div class="user-form-group user-form-verifycode">' + '<label for="J_registerVerifyCode" style="display: none;">验证码 </label>' + '<input type="text" name="code" id="J_registerVerifyCode" class="user-form-input J_verifyCode" placeholder="请输入验证码" required autocomplete="off">' + '<a href="javascript:;" class="user-form-codeImg J_imgCaptcha"><img></a>' + "</div>" + '<div class="user-form-group">' + '<label for="J_registerPassword" style="display: none;">密码 </label>' + '<input type="password" name="password" id="J_registerPassword" class="user-form-input J_password" placeholder="密码" required size="32" data-min="6" data-max="32">' + "</div>" + '<div class="user-form-footer">' + '<button class="user-button user-button-custom" type="submit">注册</button>' + "</div>" + "</form>" + "<!-- 第三方登录 -->" + (l ? '<div class="user-social"><div class="user-social-header"><span>使用社交帐号注册</span></div>' + s.social + "</div>": "") + "</div>" + '<div class="user-modal-footer">' + '<a data-target="#J_userModalWrap" class="user-modal-jumpLeft" data-ucenterSlide-to="1">返回登录</a>' + "</div>" + "</div>" + "</div>",
    s.bind = '<div class="user-modal-main"><div class="user-modal-content">' + a("绑定手机") + '<div class="user-modal-body">' + '<form id="J_bindForm" class="user-form" action="" method="post">' + '<div class="user-form-group">' + '<label for="J_phoneBind" style="display: none;">手机号 </label>' + '<input type="tel" name="phone" id="J_phoneBind" class="user-form-input J_phoneNum" placeholder="请输入您的手机号" required>' + "</div>" + '<div class="user-form-group user-form-verifycode">' + '<label for="J_bindVerifyCode" style="display: none;">手机验证码 </label>' + '<input type="text" name="code" id="J_bindVerifyCode" class="user-form-input J_phoneCode" placeholder="请输入手机验证码" size="6" required autocomplete="off" pattern="^\\d{6}$">' + '<a href="javascript:;" class="user-button user-form-codeBtn J_sendCode">获取验证码</a>' + "</div>" + '<div class="user-form-group">' + '<label for="J_bindPassword" style="display: none;">密码 </label>' + '<input type="password" name="password" id="J_bindPassword" class="user-form-input J_password" placeholder="设置密码" required size="32" data-min="6" data-max="32">' + "</div>" + '<div class="user-form-footer">' + '<button class="user-button user-button-custom" type="submit">绑定手机</button>' + "</div>" + "</form>" + "</div>" + "</div>" + "</div>",
    o
}),
function(e, t) {
    typeof define == "function" && define.amd ? define("messenger", ["require", "exports", "module"],
    function(n, r, i) {
        return t(e)
    }) : e.Messenger = t(e)
} (this,
function(e) {
    function r(e, t, n) {
        var r = "";
        arguments.length < 2 ? r = "target error - target and name are both required": typeof e != "object" ? r = "target error - target itself must be window object": typeof t != "string" && (r = "target error - target name must be string type");
        if (r) throw new Error(r);
        this.target = e,
        this.name = t,
        this.prefix = n
    }
    function i(e, n) {
        this.targets = {},
        this.name = e,
        this.listenFunc = [],
        this.prefix = n || t,
        this.initListen()
    }
    var t = "[PROJECT_NAME]",
    n = "postMessage" in window;
    return n ? r.prototype.send = function(e) {
        this.target.postMessage(this.prefix + "|" + this.name + "__Messenger__" + e, "*")
    }: r.prototype.send = function(e) {
        var t = window.navigator[this.prefix + this.name];
        if (typeof t != "function") throw new Error("target callback function is not defined");
        t(this.prefix + e, window)
    },
    i.prototype.addTarget = function(e, t) {
        var n = new r(e, t, this.prefix);
        this.targets[t] = n
    },
    i.prototype.initListen = function() {
        var e = this,
        t = function(t) {
            typeof t == "object" && t.data && (t = t.data);
            var n = t.split("__Messenger__"),
            t = n[1],
            r = n[0].split("|"),
            i = r[0],
            s = r[1];
            for (var o = 0; o < e.listenFunc.length; o++) i + s === e.prefix + e.name && e.listenFunc[o](t)
        };
        n ? "addEventListener" in document ? window.addEventListener("message", t, !1) : "attachEvent" in document && window.attachEvent("onmessage", t) : window.navigator[this.prefix + this.name] = t
    },
    i.prototype.listen = function(e) {
        var t = 0,
        n = this.listenFunc.length,
        r = !1;
        for (; t < n; t++) if (this.listenFunc[t] == e) {
            r = !0;
            break
        }
        r || this.listenFunc.push(e)
    },
    i.prototype.clear = function() {
        this.listenFunc = []
    },
    i.prototype.send = function(e) {
        var t = this.targets,
        n;
        for (n in t) t.hasOwnProperty(n) && t[n].send(e)
    },
    i
}),
function(e, t) {
    typeof define == "function" && define.amd ? define("validate", ["require", "exports", "module", "jquery"],
    function(e, n, r) {
        var i = e("jquery");
        return t(i)
    }) : t(e.jQuery)
} (this,
function(e) {
    DBC2SBC = function(e) {
        var t = "",
        n, r;
        for (n = 0; n < e.length; n++) r = e.charCodeAt(n),
        r >= 65281 && r <= 65373 ? t += String.fromCharCode(e.charCodeAt(n) - 65248) : r == 12288 ? t += String.fromCharCode(e.charCodeAt(n) - 12288 + 32) : t += e.charAt(n);
        return t
    },
    e.testRemind = function() {
        var t = e(window).width(),
        n = function(t) {
            if (!t || !t.target) return;
            t.target.id !== e.testRemind.id && e(t.target).parents("#" + e.testRemind.id).length === 0 && e.testRemind.hide()
        },
        r = function(t) {
            if (!t || !t.target) return;
            t.target.tagName.toLowerCase() !== "body" && e.testRemind.hide()
        },
        i = function() {
            if (!e.testRemind.display) return;
            var n = e(window).width();
            Math.abs(t - n) > 20 && (e.testRemind.hide(), t = n)
        };
        return {
            id: "validateRemind",
            display: !1,
            css: {},
            timer: null,
            time: 5e3,
            hide: function() {
                clearTimeout(this.timer),
                e("#" + this.id).remove(),
                this.display = !1,
                e(document).unbind({
                    touchstart: n,
                    mousedown: n,
                    keydown: r
                }),
                e(window).unbind("resize", i)
            },
            bind: function() {
                e(document).bind({
                    touchstart: n,
                    mousedown: n,
                    keydown: r
                }),
                e(window).bind("resize", i)
            }
        }
    } (),
    OBJREG = {
        EMAIL: "^[a-z0-9._%-]+@([a-z0-9-]+\\.)+[a-z]{2,4}$",
        NUMBER: "^\\-?\\d+(\\.\\d+)?$",
        URL: "^(http|https|ftp)\\:\\/\\/[a-z0-9\\-\\.]+\\.[a-z]{2,3}(:[a-z0-9]*)?\\/?([a-z0-9\\-\\._\\?\\,\\'\\/\\\\\\+&amp;%\\$#\\=~])*$",
        TEL: "^1\\d{10}$",
        ZIPCODE: "^\\d{6}$",
        prompt: {
            radio: "请选择一个选项",
            checkbox: "如果要继续，请选中此框",
            select: "请选择列表中的一项",
            email: "请输入电子邮件地址",
            url: "请输入网站地址",
            tel: "请输入手机号码",
            number: "请输入数值",
            date: "请输入日期",
            pattern: "内容格式不符合要求",
            empty: "请填写此字段",
            multiple: "多条数据使用逗号分隔"
        }
    },
    e.html5Attr = function(t, n) {
        if (!t || !n) return undefined;
        if (document.querySelector) return e(t).attr(n);
        var r;
        return r = t.getAttributeNode(n),
        r && r.nodeValue !== "" ? r.nodeValue: undefined
    },
    e.formValidate = function() {
        return {
            isSupport: function() {
                return e('<input type="email">').attr("type") === "email"
            } (),
            isEmpty: function(t, n) {
                n = n || e.html5Attr(t, "placeholder");
                var r = t.value;
                return t.type !== "password" && (r = e.trim(r)),
                r === "" || r === n ? !0 : !1
            },
            isRegex: function(t, n, r) {
                var i = t.value,
                s = i,
                o = t.getAttribute("type") + "";
                o = o.replace(/\W+$/, ""),
                o !== "password" && (s = DBC2SBC(e.trim(i)), s !== i && e(t).val(s)),
                n = n ||
                function() {
                    return e.html5Attr(t, "pattern")
                } () ||
                function() {
                    return o && e.map(o.split("|"),
                    function(e) {
                        var t = OBJREG[e.toUpperCase()];
                        if (t) return t
                    }).join("|")
                } ();
                if (s === "" || !n) return ! 0;
                var u = e(t).hasProp("multiple"),
                a = new RegExp(n, r || "i");
                if (u && !/^number|range$/i.test(o)) {
                    var f = !0;
                    return e.each(s.split(","),
                    function(t, n) {
                        n = e.trim(n),
                        f && !a.test(n) && (f = !1)
                    }),
                    f
                }
                return a.test(s)
            },
            isOverflow: function(t) {
                if (!t) return ! 1;
                var n = e(t).attr("min"),
                r = e(t).attr("max"),
                i,
                s,
                o,
                u = t.value;
                if (!n && !r) {
                    s = e(t).attr("data-min"),
                    o = e(t).attr("data-max");
                    if (s && u.length < s) e(t).testRemind("至少输入" + s + "个字符"),
                    t.focus();
                    else {
                        if (! (o && u.length > o)) return ! 1;
                        e(t).testRemind("最多输入" + o + "个字符"),
                        e(t).selectRange(o, u.length)
                    }
                } else {
                    u = Number(u),
                    i = Number(e(t).attr("step")) || 1;
                    if (n && u < n) e(t).testRemind("值必须大于或等于" + n);
                    else if (r && u > r) e(t).testRemind("值必须小于或等于" + r);
                    else {
                        if (!i || !!/^\d+$/.test(Math.abs(u - n || 0) / i)) return ! 1;
                        e(t).testRemind("值无效")
                    }
                    t.focus(),
                    t.select()
                }
                return ! 0
            },
            isAllpass: function(t, n) {
                if (!t) return ! 0;
                var r = {
                    labelDrive: !0
                };
                params = e.extend({},
                r, n || {}),
                t.size && t.size() == 1 && t.get(0).tagName.toLowerCase() == "form" ? t = t.find(":input") : t.tagName && t.tagName.toLowerCase() == "form" && (t = e(t).find(":input"));
                var i = this,
                s = !0,
                o = function(t, n, r) {
                    var i = e(t).attr("data-key"),
                    s = e("label[for='" + t.id + "']"),
                    o = "",
                    u;
                    params.labelDrive && (u = e.html5Attr(t, "placeholder"), s.each(function() {
                        var t = e(this).text();
                        t !== u && (o += t.replace(/\*|:|：/g, ""))
                    }));
                    if (e(t).isVisible()) if (n == "radio" || n == "checkbox") e(t).testRemind(OBJREG.prompt[n], {
                        align: "left"
                    }),
                    t.focus();
                    else if (r == "select" || r == "empty") e(t).testRemind(r == "empty" && o ? "您尚未输入" + o: OBJREG.prompt[r]),
                    t.focus();
                    else if (/^range|number$/i.test(n) && Number(t.value)) e(t).testRemind("值无效"),
                    t.focus(),
                    t.select();
                    else {
                        var a = OBJREG.prompt[n] || OBJREG.prompt.pattern;
                        o && (a = "您输入的" + o + "格式不准确"),
                        n != "number" && e(t).hasProp("multiple") && (a += "，" + OBJREG.prompt.multiple),
                        e(t).testRemind(a),
                        t.focus(),
                        t.select()
                    } else {
                        var f = e(t).attr("data-target"),
                        l = e("#" + f);
                        l.size() == 0 && (l = e("." + f));
                        var c = "您尚未" + (i || (r == "empty" ? "输入": "选择")) + (!/^radio|checkbox$/i.test(n) && o || "该项内容");
                        l.size() ? (l.offset().top < e(window).scrollTop() && e(window).scrollTop(l.offset().top - 50), l.testRemind(c)) : alert(c)
                    }
                    return ! 1
                };
                return t.each(function() {
                    var t = this,
                    n = t.getAttribute("type"),
                    r = t.tagName.toLowerCase(),
                    u = e(this).hasProp("required");
                    if (n) {
                        var a = n.replace(/\W+$/, "");
                        if (!params.hasTypeNormally && e.formValidate.isSupport && n != a) try {
                            t.type = a
                        } catch(f) {}
                        n = a
                    }
                    if (s == 0 || t.disabled || n == "submit" || n == "reset" || n == "file" || n == "image") return;
                    if (n == "radio" && u) {
                        var l = t.name ? e("input[type='radio'][name='" + t.name + "']") : e(t),
                        c = !1;
                        l.each(function() {
                            c == 0 && e(this).is(":checked") && (c = !0)
                        }),
                        c == 0 && (s = o(l.get(0), n, r))
                    } else n == "checkbox" && u && !e(t).is(":checked") ? s = o(t, n, r) : r == "select" && u && !t.value ? s = o(t, n, r) : u && i.isEmpty(t) || !(s = i.isRegex(t)) ? (s ? o(t, n, "empty") : o(t, n, r), s = !1) : i.isOverflow(t) && (s = !1)
                }),
                s
            }
        }
    } (),
    e.fn.extend({
        isVisible: function() {
            return e(this).attr("type") !== "hidden" && e(this).css("display") !== "none" && e(this).css("visibility") !== "hidden"
        },
        hasProp: function(t) {
            if (typeof t != "string") return undefined;
            var n = !1;
            if (document.querySelector) {
                var r = e(this).attr(t);
                r !== undefined && r !== !1 && (n = !0)
            } else {
                var i = e(this).get(0).outerHTML,
                s = i.slice(0, i.search(/\/?['"]?>(?![^<]*<['"])/));
                n = (new RegExp("\\s" + t + "\\b", "i")).test(s)
            }
            return n
        },
        selectRange: function(t, n) {
            var r = e(this).get(0);
            if (r.createTextRange) {
                var i = r.createTextRange();
                i.collapse(!0),
                i.moveEnd("character", n),
                i.moveStart("character", t),
                i.select()
            } else r.focus(),
            r.setSelectionRange(t, n);
            return this
        },
        testRemind: function(t, n) {
            var r = {
                size: 6,
                align: "center",
                css: {
                    maxWidth: 280,
                    backgroundColor: "#f4615c",
                    borderColor: "#f4615c",
                    borderRadius: "4px",
                    color: "#fff",
                    fontSize: "12px",
                    padding: "5px 10px",
                    zIndex: 9999
                }
            };
            n = n || {},
            n.css = e.extend({},
            r.css, n.css || e.testRemind.css);
            var i = e.extend({},
            r, n || {});
            if (!t || !e(this).isVisible()) return;
            var s = {
                center: "50%",
                left: "15%",
                right: "85%"
            },
            o = s[i.align] || "50%";
            i.css.position = "absolute",
            i.css.top = "-99px",
            i.css.border = "1px solid " + i.css.borderColor,
            e("#" + e.testRemind.id).size() && e.testRemind.hide(),
            this.remind = e('<div id="' + e.testRemind.id + '">' + t + "</div>").css(i.css),
            e(document.body).append(this.remind);
            var u; ! window.XMLHttpRequest && (u = parseInt(i.css.maxWidth)) && this.remind.width() > u && this.remind.width(u);
            var a = e(this).offset(),
            f = "top";
            if (!a) return e(this);
            var l = a.top - this.remind.outerHeight() - i.size;
            l < e(document).scrollTop() && (f = "bottom", l = a.top + e(this).outerHeight() + i.size);
            var c = function(t) {
                var n = "transparent",
                r = "dashed",
                s = "solid",
                o = {},
                u = {
                    width: 0,
                    height: 0,
                    overflow: "hidden",
                    borderWidth: i.size + "px",
                    position: "absolute"
                },
                a = {};
                if (t === "before") o = {
                    top: {
                        borderColor: [i.css.borderColor, n, n, n].join(" "),
                        borderStyle: [s, r, r, r].join(" "),
                        top: 0
                    },
                    bottom: {
                        borderColor: [n, n, i.css.borderColor, ""].join(" "),
                        borderStyle: [r, r, s, r].join(" "),
                        bottom: 0
                    }
                };
                else {
                    if (t !== "after") return o = null,
                    u = null,
                    a = null,
                    null;
                    o = {
                        top: {
                            borderColor: i.css.backgroundColor + ["", n, n, n].join(" "),
                            borderStyle: [s, r, r, r].join(" "),
                            top: -1
                        },
                        bottom: {
                            borderColor: [n, n, i.css.backgroundColor, ""].join(" "),
                            borderStyle: [r, r, s, r].join(" "),
                            bottom: -1
                        }
                    }
                }
                return a = e.extend({},
                o[f], u),
                e("<" + t + "></" + t + ">").css(a)
            },
            h = {
                width: 2 * i.size,
                left: o,
                marginLeft: -1 * i.size + "px",
                height: i.size,
                textIndent: 0,
                overflow: "hidden",
                position: "absolute"
            };
            return f == "top" ? h.bottom = -1 * i.size: h.top = -1 * i.size,
            this.remind.css({
                left: a.left,
                top: l,
                marginLeft: e(this).outerWidth() * .5 - this.remind.outerWidth() * parseInt(o) / 100
            }).prepend(e("<div></div>").css(h).append(c("before")).append(c("after"))),
            e.testRemind.display = !0,
            e.testRemind.bind(),
            e.testRemind.timer = setTimeout(function() {
                e.testRemind.hide()
            },
            e.testRemind.time),
            e(this)
        },
        formValidate: function(t, n) {
            var r = {
                novalidate: !0,
                submitEnabled: !0,
                validate: function() {
                    return ! 0
                }
            },
            i = e.extend({},
            r, n || {}),
            s = e(this).find(":input");
            return e.formValidate.isSupport && (i.novalidate ? e(this).attr("novalidate", "novalidate") : (s.each(function() {
                var e = this.getAttribute("type") + "",
                t = e.replace(/\W+$/, "");
                if (e != t) try {
                    this.type = t
                } catch(n) {}
            }), i.hasTypeNormally = !0)),
            i.submitEnabled && e(this).find(":disabled").each(function() { / ^image | submit$ / .test(this.type) && e(this).removeAttr("disabled")
            }),
            e(this).bind("submit",
            function() {
                return e.formValidate.isAllpass(s, i) && i.validate() && e.isFunction(t) && t.call(this),
                !1
            }),
            e(this)
        }
    })
}),
function(e, t) {
    typeof define == "function" && define.amd ? define("ucenterUI/main", ["require", "exports", "module", "jquery", "userModal", "rsa", "jsBridge", "common", "messenger", "validate"],
    function(e, n, r) {
        var i = e("jquery"),
        s = e("userModal"),
        o = e("rsa"),
        u = e("jsBridge"),
        a = e("common"),
        f = e("messenger");
        return e("validate"),
        t(i, s, o, u, a, f)
    }) : e.UCenterUI = t(e.jQuery, e.UserModal, e.RSA, e.JSBridge, e.JINCommon, e.Messenger)
} (this,
function(e, t, n, r, i, s) {
    function u() {
        this.status = !1,
        this.timer = null,
        this.dom = null,
        this.text = ""
    }
    function a() {
        var t = e('<div class="user-alert hide"></div>'),
        n = e('<div class="user-alert-wrap"></div>'),
        r = e('<a class="user-alert-close" href="javascript:;">&times;</a>'),
        i = e("<span><span>"),
        s = this;
        n.append(i),
        n.append(r),
        t.append(n),
        this.alertDom = t,
        this.alertWrap = n,
        this.textDom = i,
        this.timer = null
    }
    function f() {
        this.supportPlaceholder = "placeholder" in document.createElement("input")
    }
    function d(t) {
        this.user = null,
        this.userModal = {},
        this.path = "style",
        this.qrcodeImgTimer = null,
        this.qrcodeStatusTimer = null,
        this.isShowQrcode = !1,
        this.qrcodeImg = "",
        this.qrcodeStatus = 0,
        this.options = {},
        this.options.loginButtonDom = ".J_ucenter_login",
        this.options.registerButtonDom = ".J_ucenter_register",
        this.options.resetButtonDom = ".J_ucenter_reset",
        this.options.embedded = !1,
        e.extend(this.options, t),
        this.init()
    }
    n.setMaxDigits(131);
    var o = function(t) {
        return e.Deferred(function(e) {
            setTimeout(e.resolve, t)
        })
    };
    e.extend(u.prototype, {
        clear: function() {
            clearInterval(this.timer),
            typeof this.dom != null && (this.dom.text(this.text), this.dom.removeClass("disabled")),
            this.status = !1
        },
        set: function(e, t) {
            var n = "获取验证码",
            r = t,
            i = this;
            this.domTxt = e.text(),
            this.dom = e,
            e.addClass("disabled"),
            i.timer = setInterval(function() {
                if (r <= 0) return clearInterval(i.timer),
                e.text(i.domTxt),
                i.status = !1,
                e.removeClass("disabled"),
                !1;
                e.text(n + "(" + r + ")"),
                r -= 1
            },
            1e3)
        }
    }),
    e.extend(a.prototype, {
        show: function() {
            clearTimeout(this.timer);
            var t = this;
            e("#J_userModalList").find(".ucItem:visible .user-modal-body").prepend(this.alertDom),
            o(1).done(function() {
                t.alertDom.removeClass("hide").addClass("show")
            }),
            this.alertDom.on("click", ".user-alert-close",
            function() {
                t.hide()
            }),
            this.timer = setTimeout(function() {
                t.hide()
            },
            5e3)
        },
        hide: function() {
            var e = this;
            this.alertDom.removeClass("show").addClass("hide"),
            o(300).done(function() {
                e.alertDom.remove()
            })
        },
        error: function(e) {
            this.alertWrap.removeClass("success").addClass("error"),
            this.textDom.text(e),
            this.show()
        },
        success: function(e) {
            this.alertWrap.removeClass("error").addClass("success"),
            this.textDom.text(e),
            this.show()
        }
    }),
    e.extend(f.prototype, {
        placeholder: function(t) {
            var n = t.attr("placeholder"),
            r = t.val(),
            i = t.parent(),
            s = e('<span class="user-placeholder"></span>'),
            o = function() {
                if (i.find(".user-placeholder").length) return s.show(),
                !1;
                r && s.hide(),
                i.append(s),
                s.text(n)
            };
            o(),
            i.on("click", ".user-placeholder",
            function() {
                var t = e(this);
                t.hide(),
                t.siblings("input").focus()
            }),
            t.on("focus",
            function() {
                var t = e(this);
                s.hide()
            }),
            t.on("blur",
            function() {
                var t = e(this);
                t.val() == "" && s.show()
            })
        },
        init: function(t) {
            if (this.supportPlaceholder) return ! 1;
            var n = this,
            r = t.find("input");
            r.each(function() {
                var t = e(this);
                t.attr("placeholder") && n.placeholder(t)
            })
        }
    });
    var l = function(t) {
        e.ajax({
            url: t.url,
            data: t.data || {},
            dataType: "jsonp",
            jsonp: "jsonpCallback",
            success: function(e) {
                t.success(e)
            },
            error: function(e) {
                typeof t.error == "function" && t.error(e)
            },
            complete: function() {
                typeof t.complete == "function" && t.complete()
            }
        })
    },
    c = function(e) {
        var t = e.session_id,
        n = [],
        i = "";
        r.putData("login/index", {
            user: JSON.stringify(e)
        })
    },
    h = new a,
    p = {
        cookieName: "showCaptcha",
        formatPhone: function(e) {
            return e.replace(/(\d{3})\d{4}(\d{4})/, "$1****$2")
        },
        set: function(e) {
            var t = new Date;
            t.setTime(t.getTime() + 9e5),
            i.cookie.set(this.cookieName + this.formatPhone(e), 1, t.toGMTString(), "/", "table.com")
        },
        get: function(e) {
            return i.cookie.get(this.cookieName + this.formatPhone(e))
        },
        remove: function(e) {
            i.cookie.remove(this.cookieName + this.formatPhone(e), "/", "table.com")
        },
        showCaptcha: function() {
            var e = userModal.userModal_login.find(".user-form-verifycode");
            e.is(":visible") || e.show()
        },
        hideCaptcha: function() {
            userModal.userModal_login.find(".user-form-verifycode").hide()
        }
    };
    return e.extend(d.prototype, {
        userAction: function(e, t) {
            var n = this,
            i = this.rsaEncrypt(e),
            s = this.userModal["userModal_" + e],
            u = "",
            a = r.getUri().channel;
            a && (i.channel = a);
            if (e == "register") i.verify = s.find(".J_phoneCode").val(),
            i.user_captcha = s.find(".J_verifyCode").val();
            else if (e == "login") {
                u = s.find(".J_phoneNum").val();
                if (s.find(".user-form-verifycode").is(":visible")) i.user_captcha = s.find(".J_verifyCode").val();
                else if (p.get(u)) return p.showCaptcha(),
                n.refreshCaptcha(n.userModal.userModal_login),
                !1
            } else e == "reset" && (i.verify = s.find(".J_phoneCode").val());
            r.isApp && (i.session = r.isApp, i.device = r.getUri().device),
            this.loading.show(),
            l({
                url: n.path + t,
                data: i,
                success: function(t) {
                    n.loading.hide();
                    if (t.status_code !== 200) return e === "login" && (t.captcha ? (p.showCaptcha(), n.refreshCaptcha(n.userModal.userModal_login), p.get(u) || p.set(u)) : p.remove(u)),
                    s.find(".user-form-verifycode").is(":visible") && n.refreshCaptcha(s),
                    h.error(t.message),
                    !1;
                    if (r.isApp) c(t.data);
                    else {
                        e == "login" && p.get(u) && p.remove(u),
                        e === "register" && typeof window._czc != "undefined" && _czc.push(["_trackEvent", location.href, "register", document.referrer]),
                        h.success(t.message);
                        if (typeof n.options[e + "Callback"] == "function") return n.options[e + "Callback"].call(n, t),
                        !1;
                        o(1e3).done(function() {
                            n.afterLogin()
                        })
                    }
                }
            })
        },
        bind: function() {
            var e = this,
            t = this.rsaEncrypt("bind");
            t.verify = e.userModal.userModal_bind.find(".J_phoneCode").val(),
            this.loading.show(),
            l({
                url: e.path + "/bindMobile",
                data: t,
                success: function(t) {
                    e.loading.hide();
                    if (t.status_code !== 200) return h.error(t.message),
                    !1;
                    h.success(t.message);
                    if (typeof e.options.bindCallback == "function") return e.options.bindCallback.call(e, t),
                    !1;
                    e.userModal.hide(1e3),
                    o(1e3).done(function() {
                        e.afterLogin()
                    })
                },
                error: function(t) {
                    alert(t.responseText),
                    e.loading.hide()
                }
            })
        },
        afterLogin: function() {
            location.reload()
        },
        sendPhoneCode: function(t) {
            var r = this,
            i = e.Deferred(),
            s = new u,
            o = this.userModal["userModal_" + t.type],
            a = t.dom || o.find(".J_sendCode"),
            f = t.url,
            c = t.datas,
            p = t.time || 60,
            d = t.mobile || o.find(".J_phoneNum"),
            v = new n.RSAKeyPair("10001", "", n.rsa_n);
            return a.on("click",
            function() {
                if (!e.formValidate.isAllpass(d)) return ! 1;
                if (s.status) return ! 1;
                s.status = !0,
                l({
                    url: f || r.path + "/sendCode",
                    data: c || {
                        mobile: n.encryptedString(v, d.val())
                    },
                    success: function(e) {
                        if (e.status_code != 200) return h.error(e.message),
                        s.status = !1,
                        !1;
                        s.set(a, p),
                        i.resolve(e)
                    },
                    error: function() {
                        s.status = !1,
                        h.error("网络错误"),
                        i.reject()
                    }
                })
            }),
            i
        },
        refreshCaptcha: function(e) {
            var t = e.find(".J_imgCaptcha"),
            n = e.find(".J_verifyCode");
            if (!t.length) return ! 1;
            var r = "style/captcha?" + (new Date).valueOf();
            t.find("img").attr("src", r),
            n.val("")
        },
        rsaEncrypt: function(e) {
            var t = this.userModal["userModal_" + e].find(".J_phoneNum"),
            r = this.userModal["userModal_" + e].find(".J_password"),
            i = n.RSAKeyPair,
            s = new i("10001", "", n.rsa_n);
            return {
                mobile: t.length ? n.encryptedString(s, t.val()) : "",
                password: r.length ? n.encryptedString(s, r.val()) : ""
            }
        },
        loading: function() {
            var t = e('<div class="user-loading"></div>');
            return {
                show: function() {
                    e("body").append(t)
                },
                hide: function() {
                    t.remove()
                }
            }
        } (),
        on: function(e) {
            var t = this;
            e = e || "login",
            e == "login" ? r.isApp ? r.login() : t.userModal.show() : e == "logout" ? r.isApp ? r.logout() : location.href = "style/logout": r.isApp ? r.login() : t.userModal.show(e)
        },
        bindEvents: function() {
            var t = this,
            n = this.options;
            e(document).on("click", n.loginButtonDom,
            function() {
                t.on("login")
            }),
            e(document).on("click", n.registerButtonDom,
            function() {
                t.userModal.show("register")
            }),
            e(document).on("click", n.resetButtonDom,
            function() {
                t.userModal.show("reset")
            }),
            e(document).on("click", ".J_ucenter_logout",
            function() {
                t.on("logout")
            }),
            this.userModal.userModalDom.on("click", ".J_imgCaptcha",
            function() {
                t.refreshCaptcha(t.userModal.userModalListDom.find(".ucItem:visible"))
            }),
            e("#J_loginPhone").on("change",
            function() {
                var n = e(this),
                r = n.val(),
                i = t.userModal.userModal_login.find(".user-form-verifycode");
                i.is(":visible") ? p.get(r) ? t.refreshCaptcha(t.userModal.userModal_login) : p.hideCaptcha() : p.get(r) && (p.showCaptcha(), t.refreshCaptcha(t.userModal.userModal_login))
            }),
            e("#J_loginForm").formValidate(function() {
                t.userAction.apply(t, ["login", "/login"])
            },
            {
                validate: function() {
                    if (t.userModal.userModal_login.find(".user-form-verifycode").is(":visible")) {
                        var n = e("#J_loginVerifyCode");
                        if (n.val() === "") return n.testRemind("您尚未输入验证码"),
                        !1
                    }
                    return ! 0
                }
            }),
            e("#J_resetForm").formValidate(function() {
                t.userAction.apply(t, ["reset", "/reset"])
            }),
            e("#J_registerForm").formValidate(function() {
                t.userAction.apply(t, ["register", "/reg"])
            }),
            e("#J_bindForm").formValidate(function() {
                t.bind.apply(t, arguments)
            }),
            this.sendPhoneCode({
                type: "reset"
            }),
            this.sendPhoneCode({
                type: "register"
            }),
            this.sendPhoneCode({
                type: "bind"
            }),
            e(document).on("click", "#J_qrcodeLoginBtn",
            function() {
                e("#J_loginContent").removeClass("is-show-pc").addClass("is-show-qrcode"),
                t.isShowQrcode = !0;
                if (t.qrcodeImg) return ! 1;
                t.getQrcode(),
                t.qrcodeImgTimer = setInterval(function() {
                    t.getQrcode()
                },
                9e5)
            }),
            e(document).on("click", "#J_pcLoginBtn",
            function() {
                e("#J_loginContent").removeClass("is-show-qrcode").addClass("is-show-pc"),
                t.isShowQrcode = !1
            })
        },
        render: function() {
            this.bindEvents()
        },
        getUser: function(t) {
            var n = e.Deferred(),
            r = this;
            return this.user ? n.resolve(this.user) : e.ajax({
                url: "style/info",
                dataType: "jsonp",
                jsonp: "jsonpCallback",
                success: function(e) {
                    if (e.status_code !== 200) return n.reject(),
                    !1;
                    r.user = e.data,
                    n.resolve(r.user)
                }
            }),
            n
        },
        getQrcode: function() {
            if (!this.isShowQrcode) return ! 1;
            var t = e.Deferred(),
            n = this;
            return this.clearQrcodeInterval(),
            e.ajax({
                url: "style/qr_code",
                dataType: "jsonp",
                jsonp: "callback",
                success: function(r) {
                    if (r.status_code !== 200) return ! 1;
                    n.qrcodeImg = r.imgCode,
                    e("#J_qrcodeImg").attr("src", r.imgCode).show(),
                    n.qrcodeStatusTimer = setInterval(function() {
                        n.getQrLoginStatus(r.sid)
                    },
                    3e3);
                    var s = new Date;
                    s.setTime(s.getTime() + 9e5),
                    i.cookie.set("qrcode", r.sid, s.toGMTString(), "/", "table.com"),
                    t.resolve(r)
                }
            }),
            t
        },
        getQrLoginStatus: function(t) {
            if (!this.isShowQrcode) return ! 1;
            var n = this;
            e.ajax({
                url: "style/qr_status",
                dataType: "jsonp",
                jsonp: "callback",
                data: {
                    sid: t
                },
                success: function(t) {
                    if (t.status_code !== 200) return ! 1;
                    n.qrcodeStatus = t.status,
                    t.status == 1 && (e("#J_qrcodeInfo").hide(), e("#J_qrcodeScanError").hide(), e("#J_qrcodeScanInfo").show()),
                    t.status == 2 && (n.clearQrcodeInterval(), n.qrcodeLogin())
                }
            })
        },
        qrcodeLogin: function() {
            var t = this;
            e.ajax({
                url: "style/qrcodeLogin",
                dataType: "jsonp",
                jsonp: "jsonpCallback",
                success: function(n) {
                    if (n.status_code !== 200) return e("#J_qrcodeInfo").hide(),
                    e("#J_qrcodeScanInfo").hide(),
                    e("#J_qrcodeScanError").show(),
                    e("#J_qrcodeScanErrorText").text(n.message),
                    !1;
                    t.afterLogin()
                }
            })
        },
        clearQrcodeInterval: function() {
            clearInterval(this.qrcodeImgTimer),
            clearInterval(this.qrcodeStatusTimer)
        },
        init: function() {
            var n = this,
            u = !this.options.embedded;
            document.domain = "table.com",
            this.userModal = (new t({
                isMobile: i.device.isMobile,
                showMask: u
            })).init(),
            this.options.embedded && o(100).done(function() {
                n.userModal.show();
                var t = e("#J_userModalList").find(".ucItem:visible").length
            }),
            window.userModal = this.userModal,
            (new f).init(this.userModal.userModalDom),
            this.render(),
            typeof this.options.oauthCallback == "undefined" && (this.options.oauthCallback = function() {
                o(1e3).done(function() {
                    n.afterLogin()
                })
            }),
            typeof this.options.oauthFailCallback == "undefined" && (this.options.oauthFailCallback = function() {
                alert("第三方登陆失败")
            }),
            window.oauthCallback = this.options.oauthCallback,
            window.oauthFailCallback = this.options.oauthFailCallback;
            var a = new s("ucenterParent", "ucenterUIOauthCallback"),
            l = new s("ucenterOauthData", "ucenterUIOauthCallback");
            a.listen(function(e) {
                e == "success" ? r.isApp || oauthCallback() : e == "fail" && oauthFailCallback()
            }),
            l.listen(function(t) {
                t && r.isPcApp && (t.indexOf("&quot;") !== -1 && (t = t.replace(/&quot;/g, '"')), t = e.parseJSON(t), c(t))
            });
            var h = window.navigator.userAgent;
            return i.device.isMobile && document.addEventListener("touchstart",
            function() {},
            !0),
            this
        }
    }),
    d
});