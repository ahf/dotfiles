#!/usr/bin/env bash

notmuch new --quiet

# 0x90: BSD-dk
notmuch tag +bsd-dk +bsd-dk-announce -- folder:0x90/lists/bsd-dk/announce
notmuch tag +bsd-dk -- folder:0x90/lists/bsd-dk/bsd-dk
notmuch tag +bsd-dk-bestyrelsen -- folder:0x90/lists/bsd-dk/bestyrelsen

# 0x90: CCC mailing lists.
notmuch tag +ccc +34c3-content -- folder:0x90/lists/ccc/34c3-content
notmuch tag +ccc +34c3-resilience -- folder:0x90/lists/ccc/34c3-resilience

# 0x90: Labitat.
notmuch tag +labitat +labitat-discuss -- folder:0x90/lists/labitat/labitat-discuss
notmuch tag +labitat +labitat-members -- folder:0x90/lists/labitat/labitat-members

# Riseup: Tor mailing lists.
notmuch tag +tor +network-team -- folder:riseup/lists/tor/network-team
notmuch tag +tor +network-team-coverity -- folder:riseup/lists/tor/network-team-coverity
notmuch tag +tor +network-team-security -- folder:riseup/lists/tor/network-team-security
notmuch tag +tor +tor-announce -- folder:riseup/lists/tor/tor-announce
notmuch tag +tor +tor-dev -- folder:riseup/lists/tor/tor-dev
notmuch tag +tor +tor-internal -- folder:riseup/lists/tor/tor-internal
notmuch tag +tor +tor-meeting -- folder:riseup/lists/tor/tor-meeting
notmuch tag +tor +tor-news -- folder:riseup/lists/tor/tor-news
notmuch tag +tor +tor-onions -- folder:riseup/lists/tor/tor-onions
notmuch tag +tor +tor-project -- folder:riseup/lists/tor/tor-project
notmuch tag +tor +tor-relays -- folder:riseup/lists/tor/tor-relays
notmuch tag +tor +tor-reports -- folder:riseup/lists/tor/tor-reports
notmuch tag +tor +tor-talk -- folder:riseup/lists/tor/tor-talk
notmuch tag +tor +tor-teachers -- folder:riseup/lists/tor/tor-teachers
notmuch tag +tor +tor-team -- folder:riseup/lists/tor/tor-team
notmuch tag +tor +tor-bsd -- folder:riseup/lists/tor/tor-bsd
notmuch tag +tor +tor-researchers -- folder:riseup/lists/tor/tor-researchers
notmuch tag +tor +guardianproject-pluto -- folder:riseup/lists/tor/guardianproject-pluto

# Riseup: The Tor bugs mailing-list containing all updates to Trac.
notmuch tag +tor-bugs -- folder:riseup/lists/tor/tor-bugs

# 0x90: Tor mailing lists.
notmuch tag +tor +tor-announce -- folder:0x90/lists/tor/tor-announce
notmuch tag +tor +tor-dev -- folder:0x90/lists/tor/tor-dev
notmuch tag +tor +tor-internal -- folder:0x90/lists/tor/tor-internal
notmuch tag +tor +tor-meeting -- folder:0x90/lists/tor/tor-meeting
notmuch tag +tor +tor-onions -- folder:0x90/lists/tor/tor-onions
notmuch tag +tor +tor-project -- folder:0x90/lists/tor/tor-project
notmuch tag +tor +tor-relays -- folder:0x90/lists/tor/tor-relays
notmuch tag +tor +tor-talk -- folder:0x90/lists/tor/tor-talk
notmuch tag +tor +tor-teachers -- folder:0x90/lists/tor/tor-teachers
notmuch tag +tor +tor-team -- folder:0x90/lists/tor/tor-team

# Riseup: OONI mailing lists.
notmuch tag +ooni +ooni-dev -- folder:riseup/lists/ooni/ooni-dev
notmuch tag +ooni +ooni-talk -- folder:riseup/lists/ooni/ooni-talk

# Riseup: Riseup mailing lists.
notmuch tag +riseup +protectourspaces -- folder:riseup/lists/riseup/protectourspaces

# 0x90: Misc.
notmuch tag +inbox -- folder:0x90/inbox
notmuch tag +drafts -- folder:0x90/drafts
notmuch tag +trash -- folder:0x90/trash
notmuch tag +spam -- folder:0x90/spam

# BornHack: Misc.
notmuch tag +inbox +bornhack -- folder:bornhack/inbox
notmuch tag +drafts -- folder:bornhack/drafts
notmuch tag +trash -- folder:bornhack/trash

# Riseup: Misc.
notmuch tag +inbox +riseup -- folder:riseup/inbox
notmuch tag +drafts -- folder:riseup/drafts
notmuch tag +trash -- folder:riseup/trash
notmuch tag +spam -- folder:riseup/spam
